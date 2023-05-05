require_relative '../service'
module Adyen


  class TransactionsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Transfers"
      @client = client
      @version = version
    end

    def get_all_transactions(headers: {} , queryParams: {})
      """
      Get all transactions
      """
      endpoint = "/transactions".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_transaction(id, headers: {} )
      """
      Get a transaction
      """
      endpoint = "/transactions/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
