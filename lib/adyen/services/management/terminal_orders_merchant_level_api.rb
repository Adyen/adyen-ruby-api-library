require_relative '../service'
module Adyen


  class TerminalOrdersMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def list_billing_entities(merchantId, headers: {} , queryParams: {})
      """
      Get a list of billing entities
      """
      endpoint = "/merchants/{merchantId}/billingEntities".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_shipping_locations(merchantId, headers: {} , queryParams: {})
      """
      Get a list of shipping locations
      """
      endpoint = "/merchants/{merchantId}/shippingLocations".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_models(merchantId, headers: {} )
      """
      Get a list of terminal models
      """
      endpoint = "/merchants/{merchantId}/terminalModels".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_orders(merchantId, headers: {} , queryParams: {})
      """
      Get a list of orders
      """
      endpoint = "/merchants/{merchantId}/terminalOrders".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_order(merchantId, orderId, headers: {} )
      """
      Get an order
      """
      endpoint = "/merchants/{merchantId}/terminalOrders/{orderId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,orderId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_products(merchantId, headers: {} , queryParams: {})
      """
      Get a list of terminal products
      """
      endpoint = "/merchants/{merchantId}/terminalProducts".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_order(request, merchantId, orderId, headers: {} )
      """
      Update an order
      """
      endpoint = "/merchants/{merchantId}/terminalOrders/{orderId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,orderId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_shipping_location(request, merchantId, headers: {} )
      """
      Create a shipping location
      """
      endpoint = "/merchants/{merchantId}/shippingLocations".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_order(request, merchantId, headers: {} )
      """
      Create an order
      """
      endpoint = "/merchants/{merchantId}/terminalOrders".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_order(merchantId, orderId, headers: {} )
      """
      Cancel an order
      """
      endpoint = "/merchants/{merchantId}/terminalOrders/{orderId}/cancel".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,orderId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
