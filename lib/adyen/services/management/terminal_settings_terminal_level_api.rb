require_relative '../service'
module Adyen
  class TerminalSettingsTerminalLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def get_terminal_logo(terminalId, headers: {} )
      endpoint = "/terminals/{terminalId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [terminalId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_settings(terminalId, headers: {} )
      endpoint = "/terminals/{terminalId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [terminalId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_logo(request, terminalId, headers: {} )
      endpoint = "/terminals/{terminalId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [terminalId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_settings(request, terminalId, headers: {} )
      endpoint = "/terminals/{terminalId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [terminalId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
