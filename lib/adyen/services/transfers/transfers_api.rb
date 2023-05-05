require_relative '../service'
module Adyen


  class TransfersApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Transfers"
      @client = client
      @version = version
    end

    def transfer_funds(request, headers: {} )
      """
      Transfer funds
      """
      endpoint = "/transfers".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
