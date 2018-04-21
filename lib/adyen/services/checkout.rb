require_relative 'service'

module Adyen
  class Checkout < Service
    attr_accessor :version
    DEFAULT_VERSION = 32

    def initialize(client, version = DEFAULT_VERSION)
      service = 'PaymentSetupAndVerification'
      method_action_pairs = [
        [:payment_methods, :paymentMethods],
        [:setup, :setup],
        [:verify, :verify]
      ]

      super(client, version, service, method_action_pairs)
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
      service = 'PaymentSetupAndVerification'
      method_action_pairs = [
        [:details, :"payments/details"]
      ]

      super(client, version, service, method_action_pairs)
    end
  end
end
