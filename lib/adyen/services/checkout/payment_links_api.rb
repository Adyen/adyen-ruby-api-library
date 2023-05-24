require_relative '../service'
module Adyen
  class PaymentLinksApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Checkout'
      @client = client
      @version = version
    end

    def get_payment_link(linkId, headers: {})
      endpoint = '/paymentLinks/{linkId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, linkId)

      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_payment_link(request, linkId, headers: {})
      endpoint = '/paymentLinks/{linkId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, linkId)

      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def payment_links(request, headers: {})
      endpoint = '/paymentLinks'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
