require_relative '../service'
module Adyen
  class PaymentMethodsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def get_all_payment_methods(merchant_id, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/paymentMethodSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_payment_method_details(merchant_id, payment_method_id, headers: {})
      endpoint = '/merchants/{merchantId}/paymentMethodSettings/{paymentMethodId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payment_method_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_apple_pay_domains(merchant_id, payment_method_id, headers: {})
      endpoint = '/merchants/{merchantId}/paymentMethodSettings/{paymentMethodId}/getApplePayDomains'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payment_method_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_payment_method(request, merchant_id, payment_method_id, headers: {})
      endpoint = '/merchants/{merchantId}/paymentMethodSettings/{paymentMethodId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payment_method_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def request_payment_method(request, merchant_id, headers: {})
      endpoint = '/merchants/{merchantId}/paymentMethodSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def add_apple_pay_domain(request, merchant_id, payment_method_id, headers: {})
      endpoint = '/merchants/{merchantId}/paymentMethodSettings/{paymentMethodId}/addApplePayDomains'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payment_method_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
