require_relative './service'
module Adyen
  class PaymentsApp < Service
    attr_accessor :service, :version

    DEFAULT_VERSION = 1
    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'PaymentsApp')
    end

    def generate_payments_app_boarding_token_for_merchant(request, merchant_id, boarding_token_request, headers: {})
      endpoint = '/merchants/{merchantId}/generatePaymentsAppBoardingToken'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint,_merchant_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def generate_payments_app_boarding_token_for_store(request, merchant_id, store_id, boarding_token_request, headers: {})
      endpoint = '/merchants/{merchantId}/stores/{storeId}/generatePaymentsAppBoardingToken'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint,_merchant_id,_store_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def list_payments_app_for_merchant(merchant_id, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/paymentsApps'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint,_merchant_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_payments_app_for_store(merchant_id, store_id, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/stores/{storeId}/paymentsApps'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint,_merchant_id,_store_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def revoke_payments_app(merchant_id, installation_id, headers: {})
      endpoint = '/merchants/{merchantId}/paymentsApps/{installationId}/revoke'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint,_merchant_id,_installation_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
