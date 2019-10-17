require_relative 'service'

module Adyen
  class Checkout < Service
    DEFAULT_VERSION = 49

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
      else
        action = 'payments'
        args[1] ||= {}  # optional headers arg
        @client.call_adyen_api(@service, action, args[0], args[1], @version)
      end
    end
  end

  class CheckoutDetail < Service
    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Checkout'
      @client = client
      @version = version
    end

    def details(request, headers = {})
      action = "payments/details"
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def result(request, headers = {})
      action = "payments/result"
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
