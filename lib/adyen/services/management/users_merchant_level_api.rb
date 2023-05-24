require_relative '../service'
module Adyen
  class UsersMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def list_users(merchantId, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/users'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_user_details(merchantId, userId, headers: {})
      endpoint = '/merchants/{merchantId}/users/{userId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIduserId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_user(request, merchantId, userId, headers: {})
      endpoint = '/merchants/{merchantId}/users/{userId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIduserId)
      
      action = { method: "patch", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_new_user(request, merchantId, headers: {})
      endpoint = '/merchants/{merchantId}/users'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
