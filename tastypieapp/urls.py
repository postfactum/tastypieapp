from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

from djangotest.api import client_api

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'djangotest.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^api/', include(client_api.urls)),
    url(r'^admin/', include(admin.site.urls)),
)
