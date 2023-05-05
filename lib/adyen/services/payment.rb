require_relative './service'
module Adyen


  class Payment < Service
    attr_accessor :service, :version
    DEFAULT_VERSION = 68

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Payment"
      @client = client
      @version = version
    end

    def adjust_authorisation(request, headers: {} )
      """
      Change the authorised amount
      """
      endpoint = "/adjustAuthorisation".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
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

    def cancel(request, headers: {} )
      """
      Cancel an authorisation
      """
      endpoint = "/cancel".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_or_refund(request, headers: {} )
      """
      Cancel or refund a payment
      """
      endpoint = "/cancelOrRefund".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def capture(request, headers: {} )
      """
      Capture an authorisation
      """
      endpoint = "/capture".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def donate(request, headers: {} )
      """
      Create a donation
      """
      endpoint = "/donate".gsub(/{.+?}/, '%s') 
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

    def refund(request, headers: {} )
      """
      Refund a captured payment
      """
      endpoint = "/refund".gsub(/{.+?}/, '%s') 
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

    def technical_cancel(request, headers: {} )
      """
      Cancel an authorisation using your reference
      """
      endpoint = "/technicalCancel".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def void_pending_refund(request, headers: {} )
      """
      Cancel an in-person refund
      """
      endpoint = "/voidPendingRefund".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
