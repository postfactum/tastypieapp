from django.contrib import admin

from djangotest.campaigns.models import *

admin.site.register(Campaign)
admin.site.register(Product)
admin.site.register(Competitor)
admin.site.register(Matching)
admin.site.register(Setting)

# Register your models here.
