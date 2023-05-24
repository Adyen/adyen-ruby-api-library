# frozen_string_literal: true

require_relative '../service'
module Adyen
  class ModificationsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Checkout'
      @client = client
      @version = version
    end

    def cancel_authorised_payment(request, headers: {})
      endpoint = '/cancels'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_authorised_amount(request, paymentPspReference, headers: {})
      endpoint = '/payments/{paymentPspReference}/amountUpdates'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, paymentPspReference)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_authorised_payment_by_psp_reference(request, paymentPspReference, headers: {})
      endpoint = '/payments/{paymentPspReference}/cancels'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, paymentPspReference)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def capture_authorised_payment(request, paymentPspReference, headers: {})
      endpoint = '/payments/{paymentPspReference}/captures'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, paymentPspReference)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def refund_captured_payment(request, paymentPspReference, headers: {})
      endpoint = '/payments/{paymentPspReference}/refunds'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, paymentPspReference)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def refund_or_cancel_payment(request, paymentPspReference, headers: {})
      endpoint = '/payments/{paymentPspReference}/reversals'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, paymentPspReference)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
