from django.test import TestCase
from django.contrib.auth.models import User

from djangotest.testutils import RestApiClient
from djangotest.campaigns.models import *


class ClientApiTest(TestCase):
    maxDiff = None

    def setUp(self):
        self.api_client = RestApiClient(
            self.client, '/api/v1/')
        self.user = User.objects.create_user(
            'test_user', 'test_user@example.com', 'test_user')
        self.user.is_superuser = True
        self.user.save()
        self.client.login(username=self.user.username,
                          password='test_user')

    def test_campaign_list_get(self):
        response = self.api_client.get('campaigns')
        self.assertEqual(response.status_code, 200, msg=response.content)
        self.assertEqual(response.content_json['meta']['total_count'], 0)
        self.assertEqual(response.content_json['objects'], [])

        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_RETAIL,
            domain="example.com")

        response = self.api_client.get('campaigns')
        self.assertEqual(response.content_json['objects'], [
            {
                u'id': campaign.pk,
                u'name': u"Test campaign",
                u'domain': u"example.com",
                u'type': Campaign.TYPE_RETAIL,
                u'is_active': True,
                u'settings': u'/api/v1/campaigns/%d/settings/' % campaign.pk,
                u'resource_uri': u'/api/v1/campaigns/%d/' % campaign.pk,
            }
        ])

    def test_campaign_detail_get(self):
        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_RETAIL,
            domain="example.com")

        response = self.api_client.get('campaigns/%d' % campaign.pk)
        self.assertEqual(response.content_json, {
            u'id': campaign.pk,
            u'name': u"Test campaign",
            u'domain': u"example.com",
            u'type': Campaign.TYPE_RETAIL,
            u'is_active': True,
            u'settings': u'/api/v1/campaigns/%d/settings/' % campaign.pk,
            u'resource_uri': u'/api/v1/campaigns/%d/' % campaign.pk,
        })

    def test_campaign_settings_get(self):
        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_RETAIL,
            domain="example.com",
            is_scanning_enabled=True,
            is_url_rewriting_enabled=False)

        response = self.api_client.get('campaigns/%d/settings' % campaign.pk)
        self.assertEqual(response.content_json, {
            u'is_scanning_enabled': True,
            u'is_url_rewriting_enabled': False,
            u'resource_uri': u'/api/v1/campaigns/%d/settings/' % campaign.pk,
        })

    def test_campaign_settings_patch(self):
        campaign = Campaign.objects.create(
            name="Test",
            type=Campaign.TYPE_RETAIL,
            domain="example.com",
            is_scanning_enabled=True,
            is_url_rewriting_enabled=False)

        response = self.api_client.patch('campaigns/%d/settings' % campaign.pk, {
            'is_url_rewriting_enabled': True,
        })
        self.assertEqual(response.status_code, 202, msg=response.content)
        campaign = Campaign.objects.get(pk=campaign.pk)

        self.assertEqual(campaign.is_url_rewriting_enabled, True)

    def test_product_list_get(self):
        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_RETAIL,
            domain="example.com")

        response = self.api_client.get('campaigns/%d/products' % campaign.pk)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.content_json['meta']['total_count'], 0)
        self.assertEqual(response.content_json['objects'], [])

        product1 = campaign.products.create(
            url='http://example.com/product/1',
            title="Product 0001")
        product2 = campaign.products.create(
            url='http://example.com/product/2',
            title="Product 0002")

        response = self.api_client.get('campaigns/%d/products' % campaign.pk)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.content_json['meta']['total_count'], 2)
        self.assertEqual(response.content_json['objects'], [
            {
                u'id': product1.pk,
                u'url': u'http://example.com/product/1',
                u'title': u"Product 0001",
                u'resource_uri': u'/api/v1/campaigns/%d/products/%d/' % (
                    campaign.pk, product1.pk),
            },
            {
                u'id': product2.pk,
                u'url': u'http://example.com/product/2',
                u'title': u"Product 0002",
                u'resource_uri': '/api/v1/campaigns/%d/products/%d/' % (
                    campaign.pk, product2.pk),
            }
        ])

    def test_product_list_post(self):
        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_RETAIL,
            domain="example.com")

        response = self.api_client.post('campaigns/%d/products' % campaign.pk, {
            'url': 'http://example.com/products/1',
        })
        self.assertEqual(response.status_code, 201)
        self.assertEqual(campaign.products.count(), 1)

        product = campaign.products.all()[0]
        self.assertEqual(product.url, 'http://example.com/products/1')

    def test_product_detail_get(self):
        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_RETAIL,
            domain="example.com")

        product1 = campaign.products.create(
            url='http://example.com/product/1',
            title="Product 0001")

        response = self.api_client.get('campaigns/%d/products/%d' % (
            campaign.pk, product1.pk))
        self.assertEqual(response.status_code, 200, msg=response.content)
        self.assertEqual(response.content_json, {
            u'id': product1.pk,
            u'url': u'http://example.com/product/1',
            u'title': u"Product 0001",
            u'price': None,
            u'resource_uri': u'/api/v1/campaigns/%d/products/%d/' % (
                campaign.pk, product1.pk),
        })

    def test_product_detail_patch(self):
        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_RETAIL,
            domain="example.com")
        product1 = campaign.products.create(
            url='http://example.com/product/1')

        response = self.api_client.patch('campaigns/%d/products/%d' % (
            campaign.pk, product1.pk), {
            'url': 'http://example.com/products/1a',
            'title': 'Test title',
        })
        self.assertEqual(response.status_code, 202, msg=response.content)
        product1 = campaign.products.get(pk=product1.pk)

        self.assertEqual(product1.url, u'http://example.com/products/1a')
        self.assertEqual(product1.title, u'Test title')

    def test_product_detail_delete(self):
        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_RETAIL,
            domain="example.com")
        product1 = campaign.products.create(
            url='http://example.com/product/1')

        response = self.api_client.delete('campaigns/%d/products/%d' % (
            campaign.pk, product1.pk))
        self.assertEqual(response.status_code, 204, msg=response.content)
        self.assertEqual(campaign.products.count(), 0)

    def test_uisettings_list_get(self):
        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_VENDOR,
            domain="example.com")

        setting1 = campaign.settings.create(
            key='setting1',
            int_value=12)
        setting2 = campaign.settings.create(
            key='setting2',
            str_value='text')
        setting3 = campaign.settings.create(
            key='setting3',
            float_value=6.8)

        response = self.api_client.get(
            'campaigns/%d/ui_settings' % campaign.pk)

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.content_json, {
            "setting1": 12,
            'setting2': 'text',
            'setting3': 6.8,
        })

    def test_uisettings_list_patch(self):
        campaign = Campaign.objects.create(
            name="Test campaign",
            type=Campaign.TYPE_VENDOR,
            domain="example.com")

        setting1 = campaign.settings.create(
            key='setting1',
            int_value=12)
        setting2 = campaign.settings.create(
            key='setting2',
            str_value='text')
        setting3 = campaign.settings.create(
            key='setting3',
            float_value=6.8)

        response1 = self.api_client.patch('campaigns/%d/ui_settings/%d' % (
            campaign.pk, setting1.pk), {
            'int_value': 34,
        })

        response2 = self.api_client.patch('campaigns/%d/ui_settings/%d' % (
            campaign.pk, setting2.pk), {
            'str_value': 'new text',
        })
        response3 = self.api_client.patch('campaigns/%d/ui_settings/%d' % (
            campaign.pk, setting3.pk), {
            'float_value': 4.5,
        })

        response = self.api_client.get(
            'campaigns/%d/ui_settings' % campaign.pk)

        self.assertEqual(response1.status_code, 202)
        self.assertEqual(response2.status_code, 202)
        self.assertEqual(response3.status_code, 202)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.content_json, {
            "setting1": 34,
            'setting2': 'new text',
            'setting3': 4.5,
        })
