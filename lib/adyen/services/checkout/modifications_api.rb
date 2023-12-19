require_relative '../service'
module Adyen
  class ModificationsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Checkout')
    end

    def cancel_authorised_payment(request, headers: {})
      endpoint = '/cancels'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_authorised_amount(request, payment_psp_reference, headers: {})
      endpoint = '/payments/{paymentPspReference}/amountUpdates'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, payment_psp_reference)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_authorised_payment_by_psp_reference(request, payment_psp_reference, headers: {})
      endpoint = '/payments/{paymentPspReference}/cancels'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, payment_psp_reference)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def capture_authorised_payment(request, payment_psp_reference, headers: {})
      endpoint = '/payments/{paymentPspReference}/captures'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, payment_psp_reference)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def refund_captured_payment(request, payment_psp_reference, headers: {})
      endpoint = '/payments/{paymentPspReference}/refunds'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, payment_psp_reference)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def refund_or_cancel_payment(request, payment_psp_reference, headers: {})
      endpoint = '/payments/{paymentPspReference}/reversals'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, payment_psp_reference)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
