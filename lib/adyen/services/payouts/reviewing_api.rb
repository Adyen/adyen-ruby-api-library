require_relative '../service'
module Adyen


  class ReviewingApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Payouts"
      @client = client
      @version = version
    end

    def confirm_payout(request, headers: {} )
      """
      Confirm a payout
      """
      endpoint = "/confirmThirdParty".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_payout(request, headers: {} )
      """
      Cancel a payout
      """
      endpoint = "/declineThirdParty".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
