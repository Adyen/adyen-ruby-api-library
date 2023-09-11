require_relative '../service'
module Adyen
  class TransferRoutesApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BalancePlatform')
    end

    def calculate_transfer_routes(request, headers: {})
      endpoint = '/transferRoutes/calculate'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
