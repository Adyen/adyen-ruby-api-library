require_relative '../service'
module Adyen

  # NOTE: This class is auto generated by OpenAPI Generator
  # Ref: https://openapi-generator.tech
  #
  # Do not edit the class manually.
  class WebhooksMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    # Generate an HMAC key
    def generate_hmac_key(merchant_id, webhook_id, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}/generateHmac'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, webhook_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get a webhook
    def get_webhook(merchant_id, webhook_id, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, webhook_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # List all webhooks
    def list_all_webhooks(merchant_id, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/webhooks'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Remove a webhook
    def remove_webhook(merchant_id, webhook_id, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, webhook_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Set up a webhook
    def set_up_webhook(request, merchant_id, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Test a webhook
    def test_webhook(request, merchant_id, webhook_id, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}/test'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, webhook_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Update a webhook
    def update_webhook(request, merchant_id, webhook_id, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, webhook_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
