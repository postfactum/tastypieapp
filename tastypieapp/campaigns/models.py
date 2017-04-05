from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User
from django_pg import models as pg_models

class Campaign(models.Model):
    TYPE_RETAIL = 0
    TYPE_VENDOR = 1
    TYPE_CHOICES = (
        (TYPE_RETAIL, _("retail")),
        (TYPE_VENDOR, _("vendor")),
    )

    name = models.CharField(
        verbose_name=_("campaign name"),
        max_length=200,
        unique=True) 
    type = models.SmallIntegerField(
        verbose_name=_("campaign type"),
        choices=TYPE_CHOICES,
        default=TYPE_RETAIL)
    domain = models.CharField(
        verbose_name=_("campaign domain"),
        max_length=200,
        db_index=True)
    is_active = models.BooleanField(
        verbose_name=_("is active"),
        default=True,
        db_index=True)
    is_scanning_enabled = models.BooleanField(
        verbose_name=_("is scanning enabled"),
        default=True,
        db_index=True)
    is_url_rewriting_enabled = models.BooleanField(
        verbose_name=_("is URL rewriting enabled"),
        default=True,
        db_index=True)

    class Meta:
        verbose_name = _("Campaign")
        verbose_name_plural = _("Campaigns")
        ordering = ('name',)

    def __unicode__(self):
        return self.name


class Product(models.Model):
    campaign = models.ForeignKey(
        Campaign,
        verbose_name=_("campaign"),
        related_name='products')
    url = models.URLField(
        verbose_name=_("URL"))
    title = models.CharField(
        verbose_name=_("title"),
        max_length=500,
        blank=True,
        db_index=True)
    price = models.FloatField(
        verbose_name=_("price"),
        null=True, blank=True)

    class Meta:
        verbose_name = _("Product")
        verbose_name_plural = _("Products")
        ordering = ('title',)
        unique_together = (
            ('campaign', 'url'),
        )

    def __unicode__(self):
        return self.title or self.url


class Competitor(models.Model):
    campaign = models.ForeignKey(
        Campaign,
        verbose_name=_("campaign"),
        related_name='competitors')
    name = models.CharField(
        verbose_name=_("competitor name"),
        max_length=200,
        db_index=True)
    domain = models.CharField(
        verbose_name=_("competitor domain"),
        max_length=200,
        db_index=True)

    class Meta:
        verbose_name = _("Competitor")
        verbose_name_plural = _("Competitors")
        ordering = ('name',)
        unique_together = (
            ('campaign', 'name'),
        )

    def __unicode__(self):
        return self.name


class Matching(models.Model):
    product = models.ForeignKey(
        Product,
        verbose_name=_("product"),
        related_name='matchings')
    competitor = models.ForeignKey(
        Competitor,
        verbose_name=_("competitor"),
        related_name='matchings')
    url = models.URLField(
        verbose_name=_("URL"),
        db_index=True)
    price = models.FloatField(
        verbose_name=_("price"),
        null=True, blank=True)

    class Meta:
        verbose_name = _("Matching")
        verbose_name_plural = _("Matchings")
        ordering = ('url',)
        unique_together = (
            ('product', 'competitor', 'url'),
        )

    def __unicode__(self):
        return self.url

class Setting(models.Model):
    campaign = models.ForeignKey(
        Campaign,
        verbose_name=_("campaign"),
        related_name='settings',
        null=True, blank=True
    )
    user = models.ForeignKey(
        User,
        verbose_name=_("user"),
        related_name='settings',
        null=True, blank=True
    )
    key = models.CharField(
        verbose_name=_("key"),
        max_length=200
    )
    int_value = models.IntegerField(
        verbose_name=_("int_value"),
        null=True, blank=True
    )
    float_value = models.FloatField(
        verbose_name=_("float_value"),
        null=True, blank=True
    )
    str_value = models.TextField(
        verbose_name=_("str_value"),
        null=True, blank=True
    )
    bool_value = models.NullBooleanField(
        verbose_name=_("bool_value"),
        null=True, blank=True
    )
    json_value = pg_models.JSONField(
        verbose_name=_("Json_value"),
        max_length=400,
        null=True, blank=True
    )

    class Meta:
        verbose_name = _("Setting")
        verbose_name_plural = _("Settings")
        ordering = ('key',)
        unique_together = (
            ('campaign','user', 'key'),
        )

    def __unicode__(self):
        return self.key