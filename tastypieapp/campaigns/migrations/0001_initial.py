# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Campaign'
        db.create_table(u'campaigns_campaign', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(unique=True, max_length=200)),
            ('type', self.gf('django.db.models.fields.SmallIntegerField')(default=0)),
            ('domain', self.gf('django.db.models.fields.CharField')(max_length=200, db_index=True)),
            ('is_active', self.gf('django.db.models.fields.BooleanField')(default=True, db_index=True)),
            ('is_scanning_enabled', self.gf('django.db.models.fields.BooleanField')(default=True, db_index=True)),
            ('is_url_rewriting_enabled', self.gf('django.db.models.fields.BooleanField')(default=True, db_index=True)),
        ))
        db.send_create_signal(u'campaigns', ['Campaign'])

        # Adding model 'Product'
        db.create_table(u'campaigns_product', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('campaign', self.gf('django.db.models.fields.related.ForeignKey')(related_name='products', to=orm['campaigns.Campaign'])),
            ('url', self.gf('django.db.models.fields.URLField')(max_length=200)),
            ('title', self.gf('django.db.models.fields.CharField')(max_length=500, blank=True)),
            ('price', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
        ))
        db.send_create_signal(u'campaigns', ['Product'])

        # Adding unique constraint on 'Product', fields ['campaign', 'url']
        db.create_unique(u'campaigns_product', ['campaign_id', 'url'])

        # Adding model 'Competitor'
        db.create_table(u'campaigns_competitor', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('campaign', self.gf('django.db.models.fields.related.ForeignKey')(related_name='competitors', to=orm['campaigns.Campaign'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('domain', self.gf('django.db.models.fields.CharField')(max_length=200, db_index=True)),
        ))
        db.send_create_signal(u'campaigns', ['Competitor'])

        # Adding unique constraint on 'Competitor', fields ['campaign', 'name']
        db.create_unique(u'campaigns_competitor', ['campaign_id', 'name'])

        # Adding model 'Matching'
        db.create_table(u'campaigns_matching', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('product', self.gf('django.db.models.fields.related.ForeignKey')(related_name='matchings', to=orm['campaigns.Product'])),
            ('competitor', self.gf('django.db.models.fields.related.ForeignKey')(related_name='matchings', to=orm['campaigns.Competitor'])),
            ('url', self.gf('django.db.models.fields.URLField')(max_length=200)),
            ('price', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
        ))
        db.send_create_signal(u'campaigns', ['Matching'])

        # Adding unique constraint on 'Matching', fields ['product', 'competitor', 'url']
        db.create_unique(u'campaigns_matching', ['product_id', 'competitor_id', 'url'])


    def backwards(self, orm):
        # Removing unique constraint on 'Matching', fields ['product', 'competitor', 'url']
        db.delete_unique(u'campaigns_matching', ['product_id', 'competitor_id', 'url'])

        # Removing unique constraint on 'Competitor', fields ['campaign', 'name']
        db.delete_unique(u'campaigns_competitor', ['campaign_id', 'name'])

        # Removing unique constraint on 'Product', fields ['campaign', 'url']
        db.delete_unique(u'campaigns_product', ['campaign_id', 'url'])

        # Deleting model 'Campaign'
        db.delete_table(u'campaigns_campaign')

        # Deleting model 'Product'
        db.delete_table(u'campaigns_product')

        # Deleting model 'Competitor'
        db.delete_table(u'campaigns_competitor')

        # Deleting model 'Matching'
        db.delete_table(u'campaigns_matching')


    models = {
        u'campaigns.campaign': {
            'Meta': {'object_name': 'Campaign'},
            'domain': ('django.db.models.fields.CharField', [], {'max_length': '200', 'db_index': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True', 'db_index': 'True'}),
            'is_scanning_enabled': ('django.db.models.fields.BooleanField', [], {'default': 'True', 'db_index': 'True'}),
            'is_url_rewriting_enabled': ('django.db.models.fields.BooleanField', [], {'default': 'True', 'db_index': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '200'}),
            'type': ('django.db.models.fields.SmallIntegerField', [], {'default': '0'})
        },
        u'campaigns.competitor': {
            'Meta': {'unique_together': "(('campaign', 'name'),)", 'object_name': 'Competitor'},
            'campaign': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'competitors'", 'to': u"orm['campaigns.Campaign']"}),
            'domain': ('django.db.models.fields.CharField', [], {'max_length': '200', 'db_index': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        },
        u'campaigns.matching': {
            'Meta': {'unique_together': "(('product', 'competitor', 'url'),)", 'object_name': 'Matching'},
            'competitor': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'matchings'", 'to': u"orm['campaigns.Competitor']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'price': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'product': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'matchings'", 'to': u"orm['campaigns.Product']"}),
            'url': ('django.db.models.fields.URLField', [], {'max_length': '200'})
        },
        u'campaigns.product': {
            'Meta': {'unique_together': "(('campaign', 'url'),)", 'object_name': 'Product'},
            'campaign': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'products'", 'to': u"orm['campaigns.Campaign']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'price': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '500', 'blank': 'True'}),
            'url': ('django.db.models.fields.URLField', [], {'max_length': '200'})
        }
    }

    complete_apps = ['campaigns']