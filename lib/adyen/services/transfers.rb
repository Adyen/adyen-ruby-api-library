require_relative 'transfers/capital_api'
require_relative 'transfers/transactions_api'
require_relative 'transfers/transfers_api'

module Adyen

  # NOTE: This class is auto generated by OpenAPI Generator
  # Ref: https://openapi-generator.tech
  #
  # Do not edit the class manually.
  class Transfers
    attr_accessor :service, :version

    DEFAULT_VERSION = 4
    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Transfers'
      @client = client
      @version = version
    end

    def capital_api
      @capital_api ||= Adyen::CapitalApi.new(@client, @version)
    end

    def transactions_api
      @transactions_api ||= Adyen::TransactionsApi.new(@client, @version)
    end

    def transfers_api
      @transfers_api ||= Adyen::TransfersApi.new(@client, @version)
    end

  end
end
