module Adyen
  class Payouts
    def store_detail(request)
      action = 'storeDetail'
      @client.call_adyen_api(@service, action, request)
    end

    def store_detail_and_submit_third_party(request)
      action = 'storeDetailAndSubmitThirdParty'
      @client.call_adyen_api(@service, action, request)
    end

    def submit_third_party(request)
      action = 'submitThirdParty'
      @client.call_adyen_api(@service, action, request)
    end

    def confirm_third_party(request)
      action = 'confirmThirdParty'
      @client.call_adyen_api(@service, action, request)
    end

    def decline_third_party(request)
      action = 'declineThirdParty'
      @client.call_adyen_api(@service, action, request)
    end

    def void_pending_refund(request)
      action = 'voidPendingRefund'
      @client.call_adyen_api(@service, action, request)
    end

    def refund_with_data(request)
      action = 'refundWithData'
      @client.call_adyen_api(@service, action, request)
    end
  end
end
