require_relative '../service'
module Adyen


  class UtilityApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def get_apple_pay_session(request, headers: {} )
      """
      Get an Apple Pay session
      """
      endpoint = "/applePay/sessions".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "POST", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def origin_keys(request, headers: {} )
      """
      Create originKey values for domains
      """
      endpoint = "/originKeys".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "POST", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
