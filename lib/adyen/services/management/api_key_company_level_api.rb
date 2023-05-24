# frozen_string_literal: true

require_relative '../service'
module Adyen
  class APIKeyCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Management'
      @client = client
      @version = version
    end

    def generate_new_api_key(companyId, apiCredentialId, headers: {})
      endpoint = '/companies/{companyId}/apiCredentials/{apiCredentialId}/generateApiKey'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, companyId, apiCredentialId)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end
  end
end
