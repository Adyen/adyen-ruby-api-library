require_relative '../service'
module Adyen


  class APICredentialsCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def list_api_credentials(companyId, headers: {} , queryParams: {})
      """
      Get a list of API credentials
      """
      endpoint = "/companies/{companyId}/apiCredentials".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_api_credential(companyId, apiCredentialId, headers: {} )
      """
      Get an API credential
      """
      endpoint = "/companies/{companyId}/apiCredentials/{apiCredentialId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,apiCredentialId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_api_credential(request, companyId, apiCredentialId, headers: {} )
      """
      Update an API credential.
      """
      endpoint = "/companies/{companyId}/apiCredentials/{apiCredentialId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,apiCredentialId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_api_credential(request, companyId, headers: {} )
      """
      Create an API credential.
      """
      endpoint = "/companies/{companyId}/apiCredentials".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
