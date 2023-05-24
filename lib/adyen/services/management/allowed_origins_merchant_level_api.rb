require_relative '../service'
module Adyen
  class AllowedOriginsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def delete_allowed_origin(merchantId, apiCredentialId, originId, headers: {} )
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,apiCredentialId,originId]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_allowed_origins(merchantId, apiCredentialId, headers: {} )
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,apiCredentialId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_allowed_origin(merchantId, apiCredentialId, originId, headers: {} )
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,apiCredentialId,originId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_allowed_origin(request, merchantId, apiCredentialId, headers: {} )
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,apiCredentialId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
