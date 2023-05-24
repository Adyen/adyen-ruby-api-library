require_relative '../service'
module Adyen
  class AllowedOriginsCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def delete_allowed_origin(companyId, apiCredentialId, originId, headers: {})
      endpoint = '/companies/{companyId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdapiCredentialIdoriginId)
      
      action = { method: "delete", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_allowed_origins(companyId, apiCredentialId, headers: {})
      endpoint = '/companies/{companyId}/apiCredentials/{apiCredentialId}/allowedOrigins'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdapiCredentialId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_allowed_origin(companyId, apiCredentialId, originId, headers: {})
      endpoint = '/companies/{companyId}/apiCredentials/{apiCredentialId}/allowedOrigins/{originId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdapiCredentialIdoriginId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_allowed_origin(request, companyId, apiCredentialId, headers: {})
      endpoint = '/companies/{companyId}/apiCredentials/{apiCredentialId}/allowedOrigins'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdapiCredentialId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
