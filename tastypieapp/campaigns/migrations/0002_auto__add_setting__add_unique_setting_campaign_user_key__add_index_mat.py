# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Setting'
        db.create_table(u'campaigns_setting', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('campaign', self.gf('django.db.models.fields.related.ForeignKey')(related_name='settings', to=orm['campaigns.Campaign'])),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(related_name='settings', to=orm['auth.User'])),
            ('key', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('int_value', self.gf('django.db.models.fields.IntegerField')(null=True, blank=True)),
            ('float_value', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
            ('str_value', self.gf('django.db.models.fields.TextField')(null=True, blank=True)),
            ('bool_value', self.gf('django.db.models.fields.NullBooleanField')(null=True, blank=True)),
            ('json_value', self.gf('django_pg.models.fields.json.JSONField')(default=None, max_length=400)),
        ))
        db.send_create_signal(u'campaigns', ['Setting'])

        # Adding unique constraint on 'Setting', fields ['campaign', 'user', 'key']
        db.create_unique(u'campaigns_setting', ['campaign_id', 'user_id', 'key'])

        # Adding index on 'Matching', fields ['url']
        db.create_index(u'campaigns_matching', ['url'])

        # Adding index on 'Competitor', fields ['name']
        db.create_index(u'campaigns_competitor', ['name'])

        # Adding index on 'Product', fields ['title']
        db.create_index(u'campaigns_product', ['title'])


    def backwards(self, orm):
        # Removing index on 'Product', fields ['title']
        db.delete_index(u'campaigns_product', ['title'])

        # Removing index on 'Competitor', fields ['name']
        db.delete_index(u'campaigns_competitor', ['name'])

        # Removing index on 'Matching', fields ['url']
        db.delete_index(u'campaigns_matching', ['url'])

        # Removing unique constraint on 'Setting', fields ['campaign', 'user', 'key']
        db.delete_unique(u'campaigns_setting', ['campaign_id', 'user_id', 'key'])

        # Deleting model 'Setting'
        db.delete_table(u'campaigns_setting')


    models = {
        u'auth.group': {
            'Meta': {'object_name': 'Group'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        u'auth.permission': {
            'Meta': {'ordering': "(u'content_type__app_label', u'content_type__model', u'codename')", 'unique_together': "((u'content_type', u'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['contenttypes.ContentType']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        u'auth.user': {
            'Meta': {'object_name': 'User'},
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'related_name': "u'user_set'", 'blank': 'True', 'to': u"orm['auth.Group']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'related_name': "u'user_set'", 'blank': 'True', 'to': u"orm['auth.Permission']"}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        u'campaigns.campaign': {
            'Meta': {'ordering': "('name',)", 'object_name': 'Campaign'},
            'domain': ('django.db.models.fields.CharField', [], {'max_length': '200', 'db_index': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True', 'db_index': 'True'}),
            'is_scanning_enabled': ('django.db.models.fields.BooleanField', [], {'default': 'True', 'db_index': 'True'}),
            'is_url_rewriting_enabled': ('django.db.models.fields.BooleanField', [], {'default': 'True', 'db_index': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '200'}),
            'type': ('django.db.models.fields.SmallIntegerField', [], {'default': '0'})
        },
        u'campaigns.competitor': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('campaign', 'name'),)", 'object_name': 'Competitor'},
            'campaign': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'competitors'", 'to': u"orm['campaigns.Campaign']"}),
            'domain': ('django.db.models.fields.CharField', [], {'max_length': '200', 'db_index': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200', 'db_index': 'True'})
        },
        u'campaigns.matching': {
            'Meta': {'ordering': "('url',)", 'unique_together': "(('product', 'competitor', 'url'),)", 'object_name': 'Matching'},
            'competitor': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'matchings'", 'to': u"orm['campaigns.Competitor']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'price': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'product': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'matchings'", 'to': u"orm['campaigns.Product']"}),
            'url': ('django.db.models.fields.URLField', [], {'max_length': '200', 'db_index': 'True'})
        },
        u'campaigns.product': {
            'Meta': {'ordering': "('title',)", 'unique_together': "(('campaign', 'url'),)", 'object_name': 'Product'},
            'campaign': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'products'", 'to': u"orm['campaigns.Campaign']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'price': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'title': ('django.db.models.fields.CharField', [], {'db_index': 'True', 'max_length': '500', 'blank': 'True'}),
            'url': ('django.db.models.fields.URLField', [], {'max_length': '200'})
        },
        u'campaigns.setting': {
            'Meta': {'ordering': "('key',)", 'unique_together': "(('campaign', 'user', 'key'),)", 'object_name': 'Setting'},
            'bool_value': ('django.db.models.fields.NullBooleanField', [], {'null': 'True', 'blank': 'True'}),
            'campaign': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'settings'", 'to': u"orm['campaigns.Campaign']"}),
            'float_value': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'int_value': ('django.db.models.fields.IntegerField', [], {'null': 'True', 'blank': 'True'}),
            'json_value': ('django_pg.models.fields.json.JSONField', [], {'default': 'None', 'max_length': '400'}),
            'key': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'str_value': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'settings'", 'to': u"orm['auth.User']"})
        },
        u'contenttypes.contenttype': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        }
    }

    complete_apps = ['campaigns']