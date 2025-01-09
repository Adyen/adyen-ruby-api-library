require_relative './service'
module Adyen
  class Disputes < Service
    attr_accessor :service, :version

    DEFAULT_VERSION = 30
    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'DisputesService')
    end

    def accept_dispute(request, headers: {})
      endpoint = '/acceptDispute'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def defend_dispute(request, headers: {})
      endpoint = '/defendDispute'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def delete_dispute_defense_document(request, headers: {})
      endpoint = '/deleteDisputeDefenseDocument'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def retrieve_applicable_defense_reasons(request, headers: {})
      endpoint = '/retrieveApplicableDefenseReasons'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def supply_defense_document(request, headers: {})
      endpoint = '/supplyDefenseDocument'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
