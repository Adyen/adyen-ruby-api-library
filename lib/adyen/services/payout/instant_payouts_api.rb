require_relative '../service'
module Adyen


  class InstantPayoutsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Payout"
      @client = client
      @version = version
    end

    def make_instant_card_payout(request, headers: {} )
      """
      Make an instant card payout
      """
      endpoint = "/payout".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
