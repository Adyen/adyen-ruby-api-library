require_relative './service'
module Adyen

  # NOTE: This class is auto generated by OpenAPI Generator
  # Ref: https://openapi-generator.tech
  #
  # Do not edit the class manually.
  class PosTerminalManagement < Service
    attr_accessor :service, :version

    DEFAULT_VERSION = 1
    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'PosTerminalManagement')
    end

    # Assign terminals
    #
    # Deprecated since POS Terminal Management API v1
    # Use [Management API](https://docs.adyen.com/api-explorer/Management/latest/overview).
    def assign_terminals(request, headers: {})
      endpoint = '/assignTerminals'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Get the account or store of a terminal
    #
    # Deprecated since POS Terminal Management API v1
    # Use [Management API](https://docs.adyen.com/api-explorer/Management/latest/overview).
    def find_terminal(request, headers: {})
      endpoint = '/findTerminal'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Get the stores of an account
    #
    # Deprecated since POS Terminal Management API v1
    # Use [Management API](https://docs.adyen.com/api-explorer/Management/latest/overview).
    def get_stores_under_account(request, headers: {})
      endpoint = '/getStoresUnderAccount'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Get the details of a terminal
    #
    # Deprecated since POS Terminal Management API v1
    # Use [Management API](https://docs.adyen.com/api-explorer/Management/latest/overview).
    def get_terminal_details(request, headers: {})
      endpoint = '/getTerminalDetails'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Get the list of terminals
    #
    # Deprecated since POS Terminal Management API v1
    # Use [Management API](https://docs.adyen.com/api-explorer/Management/latest/overview).
    def get_terminals_under_account(request, headers: {})
      endpoint = '/getTerminalsUnderAccount'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
