require_relative './service'
module Adyen
  class PosMobile < Service
    attr_accessor :service, :version

    DEFAULT_VERSION = 68
    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'PosMobile')
    end

    def create_communication_session(request, headers: {})
      endpoint = '/sessions'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
