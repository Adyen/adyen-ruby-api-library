module Adyen
  class Checkout
    attr_accessor :version

    def initialize(client, version = 32)
      @client = client
      @version = version
      @service = 'PaymentSetupAndVerification'
    end

    def payments(*args)
      # This arguement length checker is to enable payments() and payments.detail()
      case args.size
      when 0
        Adyen::CheckoutDetail.new(@client)
      when 1
        action = 'payments'
        @client.call_adyen_api(@service, action, args[0], @version)
      end
    end

    def payment_methods(request)
      action = 'paymentMethods'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def setup(request)
      action = 'setup'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def verify(request)
      action = 'verify'
      @client.call_adyen_api(@service, action, request, @version)
    end
  end

  class CheckoutDetail
    def initialize(client)
      @client = client
      @service = 'PaymentSetupAndVerification'
    end

    def details(request)
      action = 'payments/details'
      @client.call_adyen_api(@service, action, request, @version)
    end
  end
end
