require_relative '../service'
module Adyen


  class AllowedOriginsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def delete_allowed_origin(merchantId, apiCredentialId, originId, headers: {} )
      """
      Delete an allowed origin
      """
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,apiCredentialId,originId]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_allowed_origins(merchantId, apiCredentialId, headers: {} )
      """
      Get a list of allowed origins
      """
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,apiCredentialId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_allowed_origin(merchantId, apiCredentialId, originId, headers: {} )
      """
      Get an allowed origin
      """
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,apiCredentialId,originId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_allowed_origin(request, merchantId, apiCredentialId, headers: {} )
      """
      Create an allowed origin
      """
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}/allowedOrigins".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,apiCredentialId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
