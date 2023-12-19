require_relative '../service'
module Adyen
  class AllowedOriginsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def delete_allowed_origin(merchant_id, api_credential_id, origin_id, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, api_credential_id, origin_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_allowed_origins(merchant_id, api_credential_id, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, api_credential_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_allowed_origin(merchant_id, api_credential_id, origin_id, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, api_credential_id, origin_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_allowed_origin(request, merchant_id, api_credential_id, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, api_credential_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
