require_relative '../service'
module Adyen


  class TerminalSettingsTerminalLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def get_terminal_logo(terminalId, headers: {} )
      """
      Get the terminal logo
      """
      endpoint = "/terminals/{terminalId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [terminalId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_settings(terminalId, headers: {} )
      """
      Get terminal settings
      """
      endpoint = "/terminals/{terminalId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [terminalId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_logo(request, terminalId, headers: {} )
      """
      Update the logo
      """
      endpoint = "/terminals/{terminalId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [terminalId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_settings(request, terminalId, headers: {} )
      """
      Update terminal settings
      """
      endpoint = "/terminals/{terminalId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [terminalId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
