require_relative '../service'
module Adyen


  class TerminalSettingsCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def get_terminal_logo(companyId, headers: {} , queryParams: {})
      """
      Get the terminal logo
      """
      endpoint = "/companies/{companyId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_settings(companyId, headers: {} )
      """
      Get terminal settings
      """
      endpoint = "/companies/{companyId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_terminal_logo(request, companyId, headers: {} , queryParams: {})
      """
      Update the terminal logo
      """
      endpoint = "/companies/{companyId}/terminalLogos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_settings(request, companyId, headers: {} )
      """
      Update terminal settings
      """
      endpoint = "/companies/{companyId}/terminalSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
