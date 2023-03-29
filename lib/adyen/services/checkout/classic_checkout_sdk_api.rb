require_relative '../service'
module Adyen


  class ClassicCheckoutSDKApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def payment_session(request, headers: {} )
      """
      Create a payment session
      """
      endpoint = "/paymentSession".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "POST", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def verify_payment_result(request, headers: {} )
      """
      Verify a payment result
      """
      endpoint = "/payments/result".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "POST", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
