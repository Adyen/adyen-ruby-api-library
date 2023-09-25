require_relative '../service'
module Adyen
  class NetworkTokensApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BalancePlatform')
    end

    def get_network_token(network_token_id, headers: {})
      endpoint = '/networkTokens/{networkTokenId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, network_token_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_network_token(request, network_token_id, headers: {})
      endpoint = '/networkTokens/{networkTokenId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, network_token_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
