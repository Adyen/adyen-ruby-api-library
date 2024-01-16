require_relative '../service'
module Adyen
  class PINFunctionalityApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BalancePlatform')
    end

    def get_rsa_publickey(headers: {}, query_params: {})
      endpoint = '/pins/publicKey'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def change_pin(request, headers: {})
      endpoint = '/pins/change'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def reveal_pin(request, headers: {})
      endpoint = '/pins/reveal'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
