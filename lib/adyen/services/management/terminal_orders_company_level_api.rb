require_relative '../service'
module Adyen


  class TerminalOrdersCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def list_billing_entities(companyId, headers: {} , queryParams: {})
      """
      Get a list of billing entities
      """
      endpoint = "/companies/{companyId}/billingEntities".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_shipping_locations(companyId, headers: {} , queryParams: {})
      """
      Get a list of shipping locations
      """
      endpoint = "/companies/{companyId}/shippingLocations".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_models(companyId, headers: {} )
      """
      Get a list of terminal models
      """
      endpoint = "/companies/{companyId}/terminalModels".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_orders(companyId, headers: {} , queryParams: {})
      """
      Get a list of orders
      """
      endpoint = "/companies/{companyId}/terminalOrders".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_order(companyId, orderId, headers: {} )
      """
      Get an order
      """
      endpoint = "/companies/{companyId}/terminalOrders/{orderId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,orderId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_products(companyId, headers: {} , queryParams: {})
      """
      Get a list of terminal products
      """
      endpoint = "/companies/{companyId}/terminalProducts".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_order(request, companyId, orderId, headers: {} )
      """
      Update an order
      """
      endpoint = "/companies/{companyId}/terminalOrders/{orderId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,orderId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_shipping_location(request, companyId, headers: {} )
      """
      Create a shipping location
      """
      endpoint = "/companies/{companyId}/shippingLocations".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_order(request, companyId, headers: {} )
      """
      Create an order
      """
      endpoint = "/companies/{companyId}/terminalOrders".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_order(companyId, orderId, headers: {} )
      """
      Cancel an order
      """
      endpoint = "/companies/{companyId}/terminalOrders/{orderId}/cancel".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,orderId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
