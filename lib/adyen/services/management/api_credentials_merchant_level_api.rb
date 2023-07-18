require_relative '../service'
module Adyen
  class APICredentialsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def list_api_credentials(merchant_id, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/apiCredentials'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_api_credential(merchant_id, api_credential_id, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials/{apiCredentialId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, api_credential_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_api_credential(request, merchant_id, api_credential_id, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials/{apiCredentialId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, api_credential_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_api_credential(request, merchant_id, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
