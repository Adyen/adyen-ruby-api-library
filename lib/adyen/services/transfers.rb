require_relative "service"

module Adyen
  class Transfers < Service
    attr_accessor :version
    DEFAULT_VERSION = 2

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Transfers"
      @client = client
      @version = version
    end

    def get_transactions(request_params)
      action = { method: 'get', url: "transactions" }

      @client.call_adyen_api(@service, action, request_params, {}, @version)
    end

    def get_transaction(transaction_id)
      action = { method: 'get', url: "transactions/" + transaction_id }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def create_transfer_request(request)
      @client.call_adyen_api(@service, "transfers", request, {}, @version)
    end
  end
end
