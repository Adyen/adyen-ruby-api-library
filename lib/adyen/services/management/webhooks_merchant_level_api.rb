require_relative '../service'
module Adyen


  class WebhooksMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def remove_webhook(merchantId, webhookId, headers: {} )
      """
      Remove a webhook
      """
      endpoint = "/merchants/{merchantId}/webhooks/{webhookId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,webhookId]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_all_webhooks(merchantId, headers: {} , queryParams: {})
      """
      List all webhooks
      """
      endpoint = "/merchants/{merchantId}/webhooks".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_webhook(merchantId, webhookId, headers: {} )
      """
      Get a webhook
      """
      endpoint = "/merchants/{merchantId}/webhooks/{webhookId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,webhookId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_webhook(request, merchantId, webhookId, headers: {} )
      """
      Update a webhook
      """
      endpoint = "/merchants/{merchantId}/webhooks/{webhookId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,webhookId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def set_up_webhook(request, merchantId, headers: {} )
      """
      Set up a webhook
      """
      endpoint = "/merchants/{merchantId}/webhooks".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def generate_hmac_key(merchantId, webhookId, headers: {} )
      """
      Generate an HMAC key
      """
      endpoint = "/merchants/{merchantId}/webhooks/{webhookId}/generateHmac".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,webhookId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def test_webhook(request, merchantId, webhookId, headers: {} )
      """
      Test a webhook
      """
      endpoint = "/merchants/{merchantId}/webhooks/{webhookId}/test".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,webhookId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
