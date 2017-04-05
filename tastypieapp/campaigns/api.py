from django.conf.urls import url, include

from tastypie.resources import Resource, ModelResource
from tastypie.resources import DeclarativeMetaclass, ModelDeclarativeMetaclass
from tastypie import fields
from tastypie import http
from tastypie.bundle import Bundle
from tastypie.utils import trailing_slash
from tastypie.exceptions import ImmediateHttpResponse

from djangotest.campaigns.models import *


class CampaignResource(ModelResource):
    settings = fields.ToOneField(
        'djangotest.campaigns.api.CampaignSettingsResource', lambda b: b.obj)

    class Meta:
        resource_name = 'campaigns'
        queryset = Campaign.objects.all()
        fields = ('id', 'name', 'type', 'domain', 'is_active')
    _sub_resources = None

    def __init__(self, *args, **kwargs):
        super(CampaignResource, self).__init__(*args, **kwargs)
        self._sub_resources = []

    def prepend_urls(self):
        return [
            url(r'^%s/(?P<campaign_id>\w+)/' % self._meta.resource_name,
                include(resource.urls))
            for resource in self._sub_resources
        ]

    def register_sub_resource(self, resource):
        self._sub_resources.append(resource)
        return resource


class CampaignSubResourceDeclarativeMetaclass(ModelDeclarativeMetaclass):

    def __new__(cls, name, bases, attrs):
        meta = attrs.get('Meta')
        if meta is not None:
            if getattr(meta, 'one_to_one_resource', None) is None:
                setattr(meta, 'one_to_one_resource', False)
            if getattr(meta, 'campaign_keyword', None) is None:
                setattr(meta, 'campaign_keyword', 'campaign_id')

        new_class = super(CampaignSubResourceDeclarativeMetaclass, cls).__new__(
            cls, name, bases, attrs)

        return new_class


class CampaignSubResource(ModelResource):
    __metaclass__ = CampaignSubResourceDeclarativeMetaclass

    def _set_campaign(self, request, **kwargs):
        if not request.user.is_authenticated():
            return request

        try:
            campaign_id = int(kwargs['campaign_id'])
        except (KeyError, ValueError):
            raise ImmediateHttpResponse(response=http.HttpNotFound())

        try:
            request.campaign = Campaign.objects.get(pk=campaign_id)
        except Campaign.DoesNotExist:
            raise ImmediateHttpResponse(response=http.HttpNotFound())

        return request

    def get_object_list(self, request):
        objects = super(CampaignSubResource, self).get_object_list(request)
        if not hasattr(objects, 'model'):
            return objects

        campaign = request.campaign

        if objects.model is Matching:
            objects = objects.filter(competitor__campaign=campaign)
        elif 'campaign' in objects.model._meta.get_all_field_names():
            objects = objects.filter(campaign=campaign)

        return objects

    def dispatch(self, request_type, request, **kwargs):
        self.is_authenticated(request)
        request = self._set_campaign(request, **kwargs)

        if self._meta.campaign_keyword != 'campaign_id':
            kwargs[self._meta.campaign_keyword] = kwargs.pop('campaign_id')

        return super(CampaignSubResource, self).dispatch(
            request_type, request, **kwargs)

    def base_urls(self):
        if self._meta.one_to_one_resource:
            urls = [
                url(r"^(?P<resource_name>%s)/schema%s$" % (self._meta.resource_name,
                                                           trailing_slash()), self.wrap_view('get_schema'), name="api_get_schema"),
                url(r"^(?P<resource_name>%s)%s$" % (self._meta.resource_name, trailing_slash(
                )), self.wrap_view('dispatch_detail'), name="api_dispatch_detail"),
            ]
        else:
            urls = super(CampaignSubResource, self).base_urls()
        return urls

    def resource_uri_kwargs(self, bundle_or_obj=None):
        if isinstance(bundle_or_obj, Bundle) and bundle_or_obj.obj is None:
            bundle_or_obj_to_pass = None
        else:
            bundle_or_obj_to_pass = bundle_or_obj

        kwargs = super(CampaignSubResource, self).resource_uri_kwargs(bundle_or_obj_to_pass)

        if isinstance(bundle_or_obj, Bundle):
            bundle = bundle_or_obj
            obj = bundle_or_obj.obj
        else:
            bundle = None
            obj = bundle_or_obj

        if obj is not None and hasattr(obj, 'campaign_id'):
            kwargs['campaign_id'] = obj.campaign_id
        elif isinstance(obj, Campaign):
            kwargs['campaign_id'] = obj.pk
        elif bundle is not None:
            kwargs['campaign_id'] = bundle.request.campaign.pk

        if self._meta.one_to_one_resource:
            del kwargs[self._meta.detail_uri_name]

        return kwargs


class CampaignSettingsResource(CampaignSubResource):

    class Meta:
        resource_name = 'settings'
        one_to_one_resource = True
        campaign_keyword = 'pk'
        queryset = Campaign.objects.all()
        fields = ('is_scanning_enabled', 'is_url_rewriting_enabled')


class ProductResource(CampaignSubResource):
    price = fields.FloatField(
        attribute='price', null=True, blank=True, use_in='detail')

    class Meta:
        resource_name = 'products'
        queryset = Product.objects.all()


class CompetitorResource(CampaignSubResource):

    class Meta:
        resource_name = 'competitors'
        queryset = Competitor.objects.all()


class MatchingResource(CampaignSubResource):

    class Meta:
        resource_name = 'matchings'
        queryset = Matching.objects.all()

class SettingResource(CampaignSubResource):

    class Meta:
        resource_name = 'ui_settings'
        queryset = Setting.objects.all()
        allowed_methods = ['get', 'patch']
        excludes = ['id']
        include_resource_uri = False

    def get_object_list(self, request):
        settings = Setting.objects.all()  # all settings

        campaign_items = settings.filter(campaign=request.campaign)  # compaign-specific items
        common_campaign_items = settings.filter(campaign=None)  # common compaign items
        user_items = settings.filter(user=request.user)  # user-specific items
        common_user_items = settings.filter(user=None)  # common user items

        priorities = [campaign_items & user_items, user_items & common_campaign_items,
                      campaign_items & common_user_items, common_user_items & common_campaign_items]
        # "folding" the list of prioritites in the right order, with union on each iteration
        result = reduce(lambda prev, next: prev | next, priorities)

        return result  # return data, according to campaign\user from request context

    def dehydrate(self, bundle):
        request_method = bundle.request.META['REQUEST_METHOD']

        if request_method == "GET":
            bundle.data = {name: value for name, value in bundle.data.items() if value or value == False}  # remove null values
            key = bundle.data.pop('key')  # get current key
            value = bundle.data.pop(bundle.data.keys()[0])  # get current value
            bundle.data[key] = value

        return bundle # return the list of bundles

    def alter_list_data_to_serialize(self, request, data):
        # Converting list of bundles
        result = {}
        for data_object in data['objects']:
            result[data_object.data.keys()[0]] = data_object.data.values()[0]  # repeatable keys will be overwritten in order of priority

        return result  # return data in the necessary format
