module Adyen
  class Payments
    attr_accessor :version

    def initialize(client, version = 32)
      @client = client
      @version = version
      @service = 'Payment'
    end

    def authorise(request)
      action = 'authorise'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def authorise3d(request)
      action = 'authorise3d'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def capture(request)
      action = 'capture'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def cancel(request)
      action = 'cancel'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def refund(request)
      action = 'refund'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def cancel_or_refund(request)
      action = 'cancelOrRefund'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def adjust_authorisation(request)
      action = 'adjustAuthorisation'
      @client.call_adyen_api(@service, action, request, @version)
    end
  end
end
