require_relative '../service'
module Adyen
  class WebhooksMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def remove_webhook(merchantId, webhookId, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdwebhookId)
      
      action = { method: "delete", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_all_webhooks(merchantId, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/webhooks'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_webhook(merchantId, webhookId, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdwebhookId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_webhook(request, merchantId, webhookId, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdwebhookId)
      
      action = { method: "patch", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def set_up_webhook(request, merchantId, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def generate_hmac_key(merchantId, webhookId, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}/generateHmac'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdwebhookId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def test_webhook(request, merchantId, webhookId, headers: {})
      endpoint = '/merchants/{merchantId}/webhooks/{webhookId}/test'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdwebhookId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
