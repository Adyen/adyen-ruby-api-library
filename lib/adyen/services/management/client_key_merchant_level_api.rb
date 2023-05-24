# frozen_string_literal: true

require_relative '../service'
module Adyen
  class ClientKeyMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Management'
      @client = client
      @version = version
    end

    def generate_new_client_key(merchantId, apiCredentialId, headers: {})
      endpoint = '/merchants/{merchantId}/apiCredentials/{apiCredentialId}/generateClientKey'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchantId, apiCredentialId)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end
  end
end
