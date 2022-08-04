require_relative "service"

module Adyen
  class Transfers < Service
    attr_accessor :version
    DEFAULT_VERSION = 3

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Transfers"
      @client = client
      @version = version
    end

    def get_transactions(request_params, headers = {})
      action = { method: 'get', url: "transactions" }

      @client.call_adyen_api(@service, action, request_params, headers, @version)
    end

    def get_transaction(transaction_id, headers = {})
      action = { method: 'get', url: "transactions/" + transaction_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_transfer_request(request, headers = {})
      @client.call_adyen_api(@service, "transfers", request, headers, @version)
    end
  end
end
