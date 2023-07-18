require_relative '../service'
module Adyen
  class RecurringApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Checkout')
    end

    def delete_token_for_stored_payment_details(recurring_id, headers: {}, query_params: {})
      endpoint = '/storedPaymentMethods/{recurringId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, recurring_id)
      endpoint += create_query_string(query_params)
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_tokens_for_stored_payment_details(headers: {}, query_params: {})
      endpoint = '/storedPaymentMethods'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
