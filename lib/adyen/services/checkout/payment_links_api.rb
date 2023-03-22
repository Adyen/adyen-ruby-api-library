module Adyen
  class PaymentLinksApi

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def get_payment_link(linkId,  headers={})
      """
      Get a payment link
      """
      endpoint = "/paymentLinks/{linkId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint % [linkId]
      action = { method: "GET", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_payment_link(request, linkId,  headers={})
      """
      Update the status of a payment link
      """
      endpoint = "/paymentLinks/{linkId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint % [linkId]
      action = { method: "PATCH", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def payment_links(request,  headers={})
      """
      Create a payment link
      """
      endpoint = "/paymentLinks".gsub(/{.+?}/, '%s') 
      endpoint = endpoint % []
      action = { method: "POST", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
