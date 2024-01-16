require_relative './service'
module Adyen
  class DataProtection < Service
    attr_accessor :service, :version

    DEFAULT_VERSION = 1
    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'DataProtection')
    end

    def request_subject_erasure(request, headers: {})
      endpoint = '/requestSubjectErasure'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
