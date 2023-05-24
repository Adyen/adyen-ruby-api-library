# frozen_string_literal: true

require_relative './service'
module Adyen
  class BalanceControlService < Service
    attr_accessor :service, :version

    DEFAULT_VERSION = 1

    def initialize(client, version = DEFAULT_VERSION)
      @service = 'BalanceControlService'
      @client = client
      @version = version
    end

    def balance_transfer(request, headers: {})
      endpoint = '/balanceTransfer'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
