require_relative '../service'
module Adyen
  class CardOrdersApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BalancePlatform')
    end

    def list_card_orders(headers: {}, query_params: {})
      endpoint = '/cardorders'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_card_order_items(id, headers: {}, query_params: {})
      endpoint = '/cardorders/{id}/items'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
