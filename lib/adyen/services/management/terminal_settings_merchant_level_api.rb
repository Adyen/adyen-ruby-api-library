require_relative '../service'
module Adyen


  class TerminalSettingsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def get_terminal_logo(merchantId, headers: {} , queryParams: {})
      """
      Get the terminal logo
      """
      endpoint = "/merchants/{merchantId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_settings(merchantId, headers: {} )
      """
      Get terminal settings
      """
      endpoint = "/merchants/{merchantId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_terminal_logo(request, merchantId, headers: {} , queryParams: {})
      """
      Update the terminal logo
      """
      endpoint = "/merchants/{merchantId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_settings(request, merchantId, headers: {} )
      """
      Update terminal settings
      """
      endpoint = "/merchants/{merchantId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
