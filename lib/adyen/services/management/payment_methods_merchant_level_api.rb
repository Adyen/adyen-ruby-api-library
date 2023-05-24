require_relative '../service'
module Adyen
  class PaymentMethodsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def get_all_payment_methods(merchantId, headers: {} , queryParams: {})
      endpoint = "/merchants/{merchantId}/paymentMethodSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_payment_method_details(merchantId, paymentMethodId, headers: {} )
      endpoint = "/merchants/{merchantId}/paymentMethodSettings/{paymentMethodId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,paymentMethodId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_apple_pay_domains(merchantId, paymentMethodId, headers: {} )
      endpoint = "/merchants/{merchantId}/paymentMethodSettings/{paymentMethodId}/getApplePayDomains".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,paymentMethodId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_payment_method(request, merchantId, paymentMethodId, headers: {} )
      endpoint = "/merchants/{merchantId}/paymentMethodSettings/{paymentMethodId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,paymentMethodId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def request_payment_method(request, merchantId, headers: {} )
      endpoint = "/merchants/{merchantId}/paymentMethodSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def add_apple_pay_domain(request, merchantId, paymentMethodId, headers: {} )
      endpoint = "/merchants/{merchantId}/paymentMethodSettings/{paymentMethodId}/addApplePayDomains".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,paymentMethodId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
