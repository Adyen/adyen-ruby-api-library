require_relative '../service'
module Adyen
  class AccountMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def list_merchant_accounts(headers: {}, query_params: {})
      endpoint = '/merchants'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_merchant_account(merchantId, headers: {})
      endpoint = '/merchants/{merchantId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_merchant_account(request, headers: {})
      endpoint = '/merchants'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def request_to_activate_merchant_account(merchantId, headers: {})
      endpoint = '/merchants/{merchantId}/activate'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
