module Adyen
  class Payouts
    attr_accessor :version

    def initialize(client, version = 30)
      @client = client
      @version = version
      @service = 'Payout'
    end

    def store_detail(request)
      action = 'storeDetail'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def store_detail_and_submit_third_party(request)
      action = 'storeDetailAndSubmitThirdParty'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def submit_third_party(request)
      action = 'submitThirdParty'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def confirm_third_party(request)
      action = 'confirmThirdParty'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def decline_third_party(request)
      action = 'declineThirdParty'
      @client.call_adyen_api(@service, action, request, @version)
    end
  end
end
