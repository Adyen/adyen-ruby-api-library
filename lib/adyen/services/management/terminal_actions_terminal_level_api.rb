require_relative '../service'
module Adyen


  class TerminalActionsTerminalLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def create_terminal_action(request, headers: {} )
      """
      Create a terminal action
      """
      endpoint = "/terminals/scheduleActions".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
