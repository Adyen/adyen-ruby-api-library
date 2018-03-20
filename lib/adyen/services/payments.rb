module Adyen
    class Payments
        def initialize(client)
            @client = client
            @service = 'Payment'
        end

        def authorise(request)
            action = 'authorise'
            @client.call_adyen_api(@service, action, request)
        end
        def authorise3d(request)
            action = 'authorise3d'
            @client.call_adyen_api(@service, action, request)
        end
        def capture(request)
            action = 'capture'
            @client.call_adyen_api(@service, action, request)
        end
        def cancel(request)
            action = 'cancel'
            @client.call_adyen_api(@service, action, request)
        end
        def refund(request)
            action = 'refund'
            @client.call_adyen_api(@service, action, request)
        end
        def cancelOrRefund(request)
            action = 'cancelOrRefund'
            @client.call_adyen_api(@service, action, request)
        end
        def adjustAuthorisation(request)
            action = 'adjustAuthorisation'
            @client.call_adyen_api(@service, action, request)
        end
    end
end

