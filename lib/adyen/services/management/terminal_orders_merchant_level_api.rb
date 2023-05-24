require_relative '../service'
module Adyen
  class TerminalOrdersMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def list_billing_entities(merchantId, headers: {} , queryParams: {})
      endpoint = "/merchants/{merchantId}/billingEntities".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_shipping_locations(merchantId, headers: {} , queryParams: {})
      endpoint = "/merchants/{merchantId}/shippingLocations".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_models(merchantId, headers: {} )
      endpoint = "/merchants/{merchantId}/terminalModels".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_orders(merchantId, headers: {} , queryParams: {})
      endpoint = "/merchants/{merchantId}/terminalOrders".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_order(merchantId, orderId, headers: {} )
      endpoint = "/merchants/{merchantId}/terminalOrders/{orderId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,orderId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_products(merchantId, headers: {} , queryParams: {})
      endpoint = "/merchants/{merchantId}/terminalProducts".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_order(request, merchantId, orderId, headers: {} )
      endpoint = "/merchants/{merchantId}/terminalOrders/{orderId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,orderId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_shipping_location(request, merchantId, headers: {} )
      endpoint = "/merchants/{merchantId}/shippingLocations".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_order(request, merchantId, headers: {} )
      endpoint = "/merchants/{merchantId}/terminalOrders".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_order(merchantId, orderId, headers: {} )
      endpoint = "/merchants/{merchantId}/terminalOrders/{orderId}/cancel".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId,orderId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
