require_relative '../service'
module Adyen
  class WebhooksCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def remove_webhook(companyId, webhookId, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdwebhookId)
      
      action = { method: "delete", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_all_webhooks(companyId, headers: {}, query_params: {})
      endpoint = '/companies/{companyId}/webhooks'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_webhook(companyId, webhookId, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdwebhookId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_webhook(request, companyId, webhookId, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdwebhookId)
      
      action = { method: "patch", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def set_up_webhook(request, companyId, headers: {})
      endpoint = '/companies/{companyId}/webhooks'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def generate_hmac_key(companyId, webhookId, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}/generateHmac'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdwebhookId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def test_webhook(request, companyId, webhookId, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}/test'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdwebhookId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
