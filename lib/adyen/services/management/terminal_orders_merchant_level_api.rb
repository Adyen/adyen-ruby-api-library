require_relative '../service'
module Adyen
  class TerminalOrdersMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def list_billing_entities(merchantId, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/billingEntities'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_shipping_locations(merchantId, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/shippingLocations'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_models(merchantId, headers: {})
      endpoint = '/merchants/{merchantId}/terminalModels'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_orders(merchantId, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/terminalOrders'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_order(merchantId, orderId, headers: {})
      endpoint = '/merchants/{merchantId}/terminalOrders/{orderId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdorderId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_products(merchantId, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/terminalProducts'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_order(request, merchantId, orderId, headers: {})
      endpoint = '/merchants/{merchantId}/terminalOrders/{orderId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdorderId)
      
      action = { method: "patch", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_shipping_location(request, merchantId, headers: {})
      endpoint = '/merchants/{merchantId}/shippingLocations'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_order(request, merchantId, headers: {})
      endpoint = '/merchants/{merchantId}/terminalOrders'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_order(merchantId, orderId, headers: {})
      endpoint = '/merchants/{merchantId}/terminalOrders/{orderId}/cancel'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdorderId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
