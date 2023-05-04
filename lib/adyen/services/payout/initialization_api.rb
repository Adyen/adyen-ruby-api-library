require_relative '../service'
module Adyen


  class InitializationApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Payout"
      @client = client
      @version = version
    end

    def store_detail(request, headers: {} )
      """
      Store payout details
      """
      endpoint = "/storeDetail".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def store_detail_and_submit_third_party(request, headers: {} )
      """
      Store details and submit a payout
      """
      endpoint = "/storeDetailAndSubmitThirdParty".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def submit_third_party(request, headers: {} )
      """
      Submit a payout
      """
      endpoint = "/submitThirdParty".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
