require_relative '../service'
module Adyen


  class AllowedOriginsCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def delete_allowed_origin(companyId, apiCredentialId, originId, headers: {} )
      """
      Delete an allowed origin
      """
      endpoint = "/companies/{companyId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,apiCredentialId,originId]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_allowed_origins(companyId, apiCredentialId, headers: {} )
      """
      Get a list of allowed origins
      """
      endpoint = "/companies/{companyId}/apiCredentials/{apiCredentialId}/allowedOrigins".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,apiCredentialId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_allowed_origin(companyId, apiCredentialId, originId, headers: {} )
      """
      Get an allowed origin
      """
      endpoint = "/companies/{companyId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,apiCredentialId,originId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_allowed_origin(request, companyId, apiCredentialId, headers: {} )
      """
      Create an allowed origin
      """
      endpoint = "/companies/{companyId}/apiCredentials/{apiCredentialId}/allowedOrigins".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,apiCredentialId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
