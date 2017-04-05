from django.contrib.auth.models import User

from tastypie.resources import Resource, ModelResource
from tastypie import fields
from tastypie.authorization import Authorization
from tastypie.exceptions import Unauthorized


class UserAuthorization(Authorization):

    def read_list(self, object_list, bundle):
        request = bundle.request
        if not request.user.is_superuser:
            raise Unauthorized("Access denied.")
        return object_list

    def read_detail(self, object_list, bundle):
        request = bundle.request
        if request.user == bundle.obj:
            return True
        if request.user.is_superuser:
            return True
        return False

    def create_list(self, object_list, bundle):
        raise Unauthorized("Access denied.")

    def create_detail(self, object_list, bundle):
        raise Unauthorized("Access denied.")

    def update_list(self, object_list, bundle):
        raise Unauthorized("Access denied.")

    def update_detail(self, object_list, bundle):
        raise Unauthorized("Access denied.")

    def delete_list(self, object_list, bundle):
        raise Unauthorized("Access denied.")

    def delete_detail(self, object_list, bundle):
        raise Unauthorized("Access denied.")


class UserResource(ModelResource):
    class Meta:
        resource_name = 'users'
        queryset = User.objects.all()
        fields = ('id', 'email', 'first_name', 'last_name', 'date_joined')
        authorization = UserAuthorization()

    def get_object_list(self, request):
        qs = super(UserResource, self).get_object_list(request)

        if not request.user.is_superuser:
            qs = qs.filter(pk=request.user.pk)

        return qs
