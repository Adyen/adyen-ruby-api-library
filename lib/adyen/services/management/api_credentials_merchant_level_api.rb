require_relative '../service'
module Adyen


  class APICredentialsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def list_api_credentials(merchantId, headers: {} , queryParams: {})
      """
      Get a list of API credentials
      """
      endpoint = "/merchants/{merchantId}/apiCredentials".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_api_credential(merchantId, apiCredentialId, headers: {} )
      """
      Get an API credential
      """
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,apiCredentialId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_api_credential(request, merchantId, apiCredentialId, headers: {} )
      """
      Update an API credential
      """
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,apiCredentialId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_api_credential(request, merchantId, headers: {} )
      """
      Create an API credential
      """
      endpoint = "/merchants/{merchantId}/apiCredentials".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
