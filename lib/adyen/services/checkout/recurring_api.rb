module Adyen


  class RecurringApi
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def delete_token_for_stored_payment_details(recurringId, headers={})
      """
      Delete a token for stored payment details
      """
      endpoint = "/storedPaymentMethods/{recurringId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [recurringId]
      action = { method: "DELETE", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_tokens_for_stored_payment_details( headers={})
      """
      Get tokens for stored payment details
      """
      endpoint = "/storedPaymentMethods".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      action = { method: "GET", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
