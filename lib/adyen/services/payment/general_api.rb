require_relative '../service'
module Adyen


  class GeneralApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Payment"
      @client = client
      @version = version
    end

    def authorise(request, headers: {} )
      """
      Create an authorisation
      """
      endpoint = "/authorise".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def authorise3d(request, headers: {} )
      """
      Complete a 3DS authorisation
      """
      endpoint = "/authorise3d".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def authorise3ds2(request, headers: {} )
      """
      Complete a 3DS2 authorisation
      """
      endpoint = "/authorise3ds2".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_authentication_result(request, headers: {} )
      """
      Get the 3DS authentication result
      """
      endpoint = "/getAuthenticationResult".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def retrieve3ds2_result(request, headers: {} )
      """
      Get the 3DS2 authentication result
      """
      endpoint = "/retrieve3ds2Result".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
