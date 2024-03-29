require_relative './service'
module Adyen
  class TerminalCloudAPI < Service
    attr_accessor :service

    def initialize(client)
      super(client, nil ,'TerminalCloudAPI')
    end

    def connected_terminals(request, headers: {})
      endpoint = '/connectedTerminals'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def sync(request, headers: {})
      endpoint = '/sync'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def async(request, headers: {})
      endpoint = '/async'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
