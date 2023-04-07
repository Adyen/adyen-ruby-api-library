require_relative '../service'
module Adyen


  class AccountStoreLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def list_stores_by_merchant_id(merchantId, headers: {} , queryParams: {})
      """
      Get a list of stores
      """
      endpoint = "/merchants/{merchantId}/stores".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_store(merchantId, storeId, headers: {} )
      """
      Get a store
      """
      endpoint = "/merchants/{merchantId}/stores/{storeId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,storeId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_stores(headers: {} , queryParams: {})
      """
      Get a list of stores
      """
      endpoint = "/stores".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_store_by_id(storeId, headers: {} )
      """
      Get a store
      """
      endpoint = "/stores/{storeId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [storeId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_store(request, merchantId, storeId, headers: {} )
      """
      Update a store
      """
      endpoint = "/merchants/{merchantId}/stores/{storeId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,storeId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_store_by_id(request, storeId, headers: {} )
      """
      Update a store
      """
      endpoint = "/stores/{storeId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [storeId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_store_by_merchant_id(request, merchantId, headers: {} )
      """
      Create a store
      """
      endpoint = "/merchants/{merchantId}/stores".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_store(request, headers: {} )
      """
      Create a store
      """
      endpoint = "/stores".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
