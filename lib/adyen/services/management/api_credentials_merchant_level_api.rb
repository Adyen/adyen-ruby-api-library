require_relative '../service'
module Adyen
  class APICredentialsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def list_api_credentials(merchantId, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/apiCredentials'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchantId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_api_credential(merchantId, apiCredentialId, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials/{apiCredentialId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchantId, apiCredentialId)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_api_credential(request, merchantId, apiCredentialId, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials/{apiCredentialId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchantId, apiCredentialId)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_api_credential(request, merchantId, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchantId)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
