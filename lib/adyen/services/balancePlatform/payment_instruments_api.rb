require_relative '../service'
module Adyen


  class PaymentInstrumentsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "BalancePlatform"
      @client = client
      @version = version
    end

    def get_payment_instrument(id, headers: {} )
      """
      Get a payment instrument
      """
      endpoint = "/paymentInstruments/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_pan_of_payment_instrument(id, headers: {} )
      """
      Get the PAN of a payment instrument
      """
      endpoint = "/paymentInstruments/{id}/reveal".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_all_transaction_rules_for_payment_instrument(id, headers: {} )
      """
      Get all transaction rules for a payment instrument
      """
      endpoint = "/paymentInstruments/{id}/transactionRules".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_payment_instrument(request, id, headers: {} )
      """
      Update a payment instrument
      """
      endpoint = "/paymentInstruments/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_payment_instrument(request, headers: {} )
      """
      Create a payment instrument
      """
      endpoint = "/paymentInstruments".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
