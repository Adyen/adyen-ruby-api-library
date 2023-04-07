require_relative '../service'
module Adyen


  class MyAPICredentialApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def remove_allowed_origin(originId, headers: {} )
      """
      Remove allowed origin
      """
      endpoint = "/me/allowedOrigins/{originId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [originId]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_api_credential_details(headers: {} )
      """
      Get API credential details
      """
      endpoint = "/me".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_allowed_origins(headers: {} )
      """
      Get allowed origins
      """
      endpoint = "/me/allowedOrigins".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_allowed_origin_details(originId, headers: {} )
      """
      Get allowed origin details
      """
      endpoint = "/me/allowedOrigins/{originId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [originId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def add_allowed_origin(request, headers: {} )
      """
      Add allowed origin
      """
      endpoint = "/me/allowedOrigins".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
