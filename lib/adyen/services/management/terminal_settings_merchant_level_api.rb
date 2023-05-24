require_relative '../service'
module Adyen
  class TerminalSettingsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def get_terminal_logo(merchantId, headers: {} , queryParams: {})
      endpoint = "/merchants/{merchantId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_settings(merchantId, headers: {} )
      endpoint = "/merchants/{merchantId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_terminal_logo(request, merchantId, headers: {} , queryParams: {})
      endpoint = "/merchants/{merchantId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_settings(request, merchantId, headers: {} )
      endpoint = "/merchants/{merchantId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [merchantId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
