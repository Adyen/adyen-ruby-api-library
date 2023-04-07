require_relative '../service'
module Adyen


  class TerminalActionsCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def list_android_apps(companyId, headers: {} , queryParams: {})
      """
      Get a list of Android apps
      """
      endpoint = "/companies/{companyId}/androidApps".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_android_certificates(companyId, headers: {} , queryParams: {})
      """
      Get a list of Android certificates
      """
      endpoint = "/companies/{companyId}/androidCertificates".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_actions(companyId, headers: {} , queryParams: {})
      """
      Get a list of terminal actions
      """
      endpoint = "/companies/{companyId}/terminalActions".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_action(companyId, actionId, headers: {} )
      """
      Get terminal action
      """
      endpoint = "/companies/{companyId}/terminalActions/{actionId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [companyId,actionId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
