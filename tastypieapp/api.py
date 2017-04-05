import tastypie
from tastypie.api import Api
from tastypie.authentication import (Authentication, ApiKeyAuthentication,
                                     SessionAuthentication,
                                     MultiAuthentication)
from tastypie.authorization import DjangoAuthorization

from djangotest.auth.api import *
from djangotest.campaigns.api import *


class AuthApi(Api):
    authentication = None
    authorization = None

    def register(self, resource, **kwargs):
        if self.authentication is not None:
            resource._meta.authentication = self.authentication
        if self.authorization is not None:
            resource._meta.authorization = self.authorization
        super(AuthApi, self).register(resource, **kwargs)


class ClientApi(AuthApi):
    authentication = MultiAuthentication(ApiKeyAuthentication(),
                                         SessionAuthentication())
    authorization = DjangoAuthorization()


client_api = ClientApi(api_name='v1')
client_api.register(UserResource())

campaign_resource = CampaignResource()
client_api.register(campaign_resource)
client_api.register(campaign_resource.register_sub_resource(CampaignSettingsResource()))
client_api.register(campaign_resource.register_sub_resource(ProductResource()))
client_api.register(campaign_resource.register_sub_resource(CompetitorResource()))
client_api.register(campaign_resource.register_sub_resource(MatchingResource()))
client_api.register(campaign_resource.register_sub_resource(SettingResource()))