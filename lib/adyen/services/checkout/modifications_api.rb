require_relative '../service'
module Adyen


  class ModificationsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def cancel_authorised_payment(request, headers: {} )
      """
      Cancel an authorised payment
      """
      endpoint = "/cancels".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_authorised_amount(request, paymentPspReference, headers: {} )
      """
      Update an authorised amount
      """
      endpoint = "/payments/{paymentPspReference}/amountUpdates".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [paymentPspReference]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_authorised_payment_by_psp_reference(request, paymentPspReference, headers: {} )
      """
      Cancel an authorised payment
      """
      endpoint = "/payments/{paymentPspReference}/cancels".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [paymentPspReference]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def capture_authorised_payment(request, paymentPspReference, headers: {} )
      """
      Capture an authorised payment
      """
      endpoint = "/payments/{paymentPspReference}/captures".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [paymentPspReference]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def refund_captured_payment(request, paymentPspReference, headers: {} )
      """
      Refund a captured payment
      """
      endpoint = "/payments/{paymentPspReference}/refunds".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [paymentPspReference]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def refund_or_cancel_payment(request, paymentPspReference, headers: {} )
      """
      Refund or cancel a payment
      """
      endpoint = "/payments/{paymentPspReference}/reversals".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [paymentPspReference]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
