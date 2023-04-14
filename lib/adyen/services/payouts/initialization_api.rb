require_relative '../service'
module Adyen


  class InitializationApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Payouts"
      @client = client
      @version = version
    end

    def store_payout_details(request, headers: {} )
      """
      Store payout details
      """
      endpoint = "/storeDetail".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def store_details_and_submit_payout(request, headers: {} )
      """
      Store details and submit a payout
      """
      endpoint = "/storeDetailAndSubmitThirdParty".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def submit_payout(request, headers: {} )
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
