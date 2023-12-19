require_relative './service'
module Adyen
  class BinLookup < Service
    attr_accessor :service, :version

    DEFAULT_VERSION = 54
    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BinLookup')
    end

    def get3ds_availability(request, headers: {})
      endpoint = '/get3dsAvailability'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_cost_estimate(request, headers: {})
      endpoint = '/getCostEstimate'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
