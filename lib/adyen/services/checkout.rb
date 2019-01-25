require_relative 'service'

module Adyen
  class Checkout < Service
    DEFAULT_VERSION = 40

    def initialize(client, version = DEFAULT_VERSION)
      service = 'Checkout'
      method_names = [
        :payment_methods,
        :payment_session
      ]

      super(client, version, service, method_names)
    end

    # This method can't be dynamically defined because
    # it needs to be both a method and a class
    # to enable payments() and payments.detail(),
    # which is accomplished via an argument length checker
    # and the CheckoutDetail class below
    def payments(*args)
      case args.size
      when 0
        Adyen::CheckoutDetail.new(@client, @version)
      when 1
        action = 'payments'
        @client.call_adyen_api(@service, action, args[0], @version)
      end
    end
  end

  class CheckoutDetail < Service
    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Checkout'
      @client = client
      @version = version
    end

    def details(request)
      action = "payments/details"
      @client.call_adyen_api(@service, action, request, @version)
    end

    def result(request)
      action = "payments/result"
      @client.call_adyen_api(@service, action, request, @version)
    end
  end
end
