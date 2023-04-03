require_relative '../service'
module Adyen


  class RecurringApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def delete_token_for_stored_payment_details(recurringId, headers: {} , queryParams: {})
      """
      Delete a token for stored payment details
      """
      endpoint = "/storedPaymentMethods/{recurringId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [recurringId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_tokens_for_stored_payment_details(headers: {} , queryParams: {})
      """
      Get tokens for stored payment details
      """
      endpoint = "/storedPaymentMethods".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
