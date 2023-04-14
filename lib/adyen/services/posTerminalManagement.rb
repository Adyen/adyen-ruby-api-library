require_relative './service'
module Adyen


  class PosTerminalManagement < Service
    attr_accessor :service, :version
    DEFAULT_VERSION = 1

    def initialize(client, version = DEFAULT_VERSION)
      @service = "PosTerminalManagement"
      @client = client
      @version = version
    end

    def assign_terminals(request, headers: {} )
      """
      Assign terminals
      """
      endpoint = "/assignTerminals".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def find_terminal(request, headers: {} )
      """
      Get the account or store of a terminal
      """
      endpoint = "/findTerminal".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_stores_under_account(request, headers: {} )
      """
      Get the stores of an account
      """
      endpoint = "/getStoresUnderAccount".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_terminal_details(request, headers: {} )
      """
      Get the details of a terminal
      """
      endpoint = "/getTerminalDetails".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_terminals_under_account(request, headers: {} )
      """
      Get the list of terminals
      """
      endpoint = "/getTerminalsUnderAccount".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
