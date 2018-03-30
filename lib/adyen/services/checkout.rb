module Adyen
  class Checkout
    def initialize(client)
      @client = client
      @service = 'PaymentSetupAndVerification'
    end

    def payments(*args)
      # This arguement length checker is to enable payments() and payments.detail()
      case args.size
      when 0
        Adyen::CheckoutDetail.new(@client)
      when 1
        action = 'payments'
        @client.call_adyen_api(@service, action, args[0])
      end
    end

    def payment_methods(request)
      action = 'paymentMethods'
      @client.call_adyen_api(@service, action, request)
    end

    def setup(request)
      action = 'setup'
      @client.call_adyen_api(@service, action, request)
    end

    def verify(request)
      action = 'verify'
      @client.call_adyen_api(@service, action, request)
    end
  end

  class CheckoutDetail
    def initialize(client)
      @client = client
      @service = 'PaymentSetupAndVerification'
    end

    def details(request)
      action = 'payments/details'
      @client.call_adyen_api(@service, action, request)
    end
  end
end
