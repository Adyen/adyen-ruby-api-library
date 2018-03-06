module Adyen
  class Checkout
    def initialize(client)
      @client = client
      @service = 'Checkout'
    end

    def payments(request)
      action = 'Payments'
      @client.call_adyen_api(@service, action, request)
    end

    def payments(*args)
      # This arguement length checker is to enable payments() and payments.detail()
      case args.size
      when 0
        Adyen::CheckoutDetail.new(@client)
      when 1
        action = 'Payments'
        @client.call_adyen_api(@service, action, args[0])
      end
    end

    def paymentMethods(request)
      action = 'PaymentMethods'
      @client.call_adyen_api(@service, action, request)
    end

    def paymentDetail(request)
      action = 'Payments/detail'
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
      @service = 'Checkout'
    end
    def detail(request)
      action = 'Payments/detail'
      @client.call_adyen_api(@service, action, request)
    end
  end
end
