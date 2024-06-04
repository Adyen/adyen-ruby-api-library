require_relative '../service'
module Adyen
  class RecurringApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Checkout')
    end

    def delete_token_for_stored_payment_details(stored_payment_method_id, headers: {}, query_params: {})
      endpoint = '/storedPaymentMethods/{storedPaymentMethodId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, stored_payment_method_id)
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

    def stored_payment_methods(request, headers: {})
      endpoint = '/storedPaymentMethods'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
