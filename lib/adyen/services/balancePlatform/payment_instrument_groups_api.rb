require_relative '../service'
module Adyen


  class PaymentInstrumentGroupsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "BalancePlatform"
      @client = client
      @version = version
    end

    def get_payment_instrument_group(id, headers: {} )
      """
      Get a payment instrument group
      """
      endpoint = "/paymentInstrumentGroups/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_all_transaction_rules_for_payment_instrument_group(id, headers: {} )
      """
      Get all transaction rules for a payment instrument group
      """
      endpoint = "/paymentInstrumentGroups/{id}/transactionRules".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_payment_instrument_group(request, headers: {} )
      """
      Create a payment instrument group
      """
      endpoint = "/paymentInstrumentGroups".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
