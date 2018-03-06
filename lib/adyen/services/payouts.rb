module Adyen
    class Payouts
        def storeDetail(request)
            action = 'storeDetail'
            @client.call_adyen_api(@service, action, request)
        end
        def storeDetailAndSubmitThirdParty(request)
            action = 'storeDetailAndSubmitThirdParty'
            @client.call_adyen_api(@service, action, request)
        end
        def submitThirdParty(request)
            action = 'submitThirdParty'
            @client.call_adyen_api(@service, action, request)
        end
        def confirmThirdParty(request)
            action = 'confirmThirdParty'
            @client.call_adyen_api(@service, action, request)
        end
        def declineThirdParty(request)
            action = 'declineThirdParty'
            @client.call_adyen_api(@service, action, request)
        end
        def voidPendingRefund(request)
            action = 'voidPendingRefund'
            @client.call_adyen_api(@service, action, request)
        end
        def refundWithData(request)
            action = 'refundWithData'
            @client.call_adyen_api(@service, action, request)
        end
    end
    
end