require_relative '../service'
module Adyen


  class WebhooksCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def remove_webhook(companyId, webhookId, headers: {} )
      """
      Remove a webhook
      """
      endpoint = "/companies/{companyId}/webhooks/{webhookId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,webhookId]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_all_webhooks(companyId, headers: {} , queryParams: {})
      """
      List all webhooks
      """
      endpoint = "/companies/{companyId}/webhooks".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_webhook(companyId, webhookId, headers: {} )
      """
      Get a webhook
      """
      endpoint = "/companies/{companyId}/webhooks/{webhookId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,webhookId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_webhook(request, companyId, webhookId, headers: {} )
      """
      Update a webhook
      """
      endpoint = "/companies/{companyId}/webhooks/{webhookId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,webhookId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def set_up_webhook(request, companyId, headers: {} )
      """
      Set up a webhook
      """
      endpoint = "/companies/{companyId}/webhooks".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def generate_hmac_key(companyId, webhookId, headers: {} )
      """
      Generate an HMAC key
      """
      endpoint = "/companies/{companyId}/webhooks/{webhookId}/generateHmac".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,webhookId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def test_webhook(request, companyId, webhookId, headers: {} )
      """
      Test a webhook
      """
      endpoint = "/companies/{companyId}/webhooks/{webhookId}/test".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,webhookId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
