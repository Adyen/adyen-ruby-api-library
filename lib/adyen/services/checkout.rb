require_relative "service"

module Adyen
  class Checkout < Service
    DEFAULT_VERSION = 68

    def initialize(client, version = DEFAULT_VERSION)
      service = "Checkout"
      method_names = [
        :payment_session,
        :origin_keys,
        :sessions
      ]

      with_application_info = [
        :payment_session,
      ]

      super(client, version, service, method_names, with_application_info)
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
        action = "payments"
        args[1] ||= {}  # optional headers arg
        @client.call_adyen_api(@service, action, args[0], args[1], @version, true)
      end
    end

    def payment_links(*args)
      case args.size
      when 0
        Adyen::CheckoutLink.new(@client, @version)
      else
        action = "paymentLinks"
        args[1] ||= {}  # optional headers arg
        @client.call_adyen_api(@service, action, args[0], args[1], @version, true)
      end
    end

    def payment_methods(*args)
      case args.size
      when 0
        Adyen::CheckoutMethod.new(@client, @version)
      else
        action = "paymentMethods"
        args[1] ||= {}  # optional headers arg
        @client.call_adyen_api(@service, action, args[0], args[1], @version)
      end
    end

    def orders(*args)
      case args.size
      when 0
        Adyen::CheckoutOrder.new(@client, @version)
      else
        action = "orders"
        args[1] ||= {}  # optional headers arg
        @client.call_adyen_api(@service, action, args[0], args[1], @version)
      end
    end

    def apple_pay
      @apple_pay ||= Adyen::CheckoutApplePay.new(@client, @version)
    end
  end

  class CheckoutDetail < Service
    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
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

  class CheckoutLink < Service
    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def get(linkId, headers = {})
      action = { method: 'get', url: "paymentLinks/" + linkId }
      @client.call_adyen_api(@service, action, {}, headers, @version, true)
    end

    def update(linkId, request, headers = {})
      action = { method: 'patch', url: "paymentLinks/" + linkId }
      @client.call_adyen_api(@service, action, request, headers, @version, false)
    end
  end

  class CheckoutMethod < Service
    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def balance(request, headers = {})
      action = "paymentMethods/balance"
      @client.call_adyen_api(@service, action, request, headers, @version, true)
    end
  end

  class CheckoutOrder < Service
    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def cancel(request, headers = {})
      action = "orders/cancel"
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end

  class CheckoutApplePay < Service
    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def sessions(request, headers = {})
      action = "applePay/sessions"
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
