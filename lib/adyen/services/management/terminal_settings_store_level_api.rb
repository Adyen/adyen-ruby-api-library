require_relative '../service'
module Adyen


  class TerminalSettingsStoreLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def get_terminal_logo(merchantId, reference, headers: {} , queryParams: {})
      """
      Get the terminal logo
      """
      endpoint = "/merchants/{merchantId}/stores/{reference}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,reference]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_settings(merchantId, reference, headers: {} )
      """
      Get terminal settings
      """
      endpoint = "/merchants/{merchantId}/stores/{reference}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,reference]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_logo_by_store_id(storeId, headers: {} , queryParams: {})
      """
      Get the terminal logo
      """
      endpoint = "/stores/{storeId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [storeId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_settings_by_store_id(storeId, headers: {} )
      """
      Get terminal settings
      """
      endpoint = "/stores/{storeId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [storeId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_terminal_logo(request, merchantId, reference, headers: {} , queryParams: {})
      """
      Update the terminal logo
      """
      endpoint = "/merchants/{merchantId}/stores/{reference}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,reference]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_settings(request, merchantId, reference, headers: {} )
      """
      Update terminal settings
      """
      endpoint = "/merchants/{merchantId}/stores/{reference}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,reference]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_logo_by_store_id(request, storeId, headers: {} , queryParams: {})
      """
      Update the terminal logo
      """
      endpoint = "/stores/{storeId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [storeId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_settings_by_store_id(request, storeId, headers: {} )
      """
      Update terminal settings
      """
      endpoint = "/stores/{storeId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [storeId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
