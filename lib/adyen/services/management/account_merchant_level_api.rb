require_relative '../service'
module Adyen


  class AccountMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def list_merchant_accounts(headers: {} , queryParams: {})
      """
      Get a list of merchant accounts
      """
      endpoint = "/merchants".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_merchant_account(merchantId, headers: {} )
      """
      Get a merchant account
      """
      endpoint = "/merchants/{merchantId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_merchant_account(request, headers: {} )
      """
      Create a merchant account
      """
      endpoint = "/merchants".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def request_to_activate_merchant_account(merchantId, headers: {} )
      """
      Request to activate a merchant account
      """
      endpoint = "/merchants/{merchantId}/activate".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
