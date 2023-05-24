require_relative '../service'
module Adyen
  class TerminalActionsCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def list_android_apps(companyId, headers: {}, query_params: {})
      endpoint = '/companies/{companyId}/androidApps'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_android_certificates(companyId, headers: {}, query_params: {})
      endpoint = '/companies/{companyId}/androidCertificates'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_terminal_actions(companyId, headers: {}, query_params: {})
      endpoint = '/companies/{companyId}/terminalActions'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyId)
      endpoint = endpoint + create_query_string(query_params)
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_action(companyId, actionId, headers: {})
      endpoint = '/companies/{companyId}/terminalActions/{actionId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointcompanyIdactionId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
