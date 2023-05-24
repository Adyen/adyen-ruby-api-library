require_relative '../service'
module Adyen
  class ClientKeyCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def generate_new_client_key(companyId, apiCredentialId, headers: {} )
      endpoint = "/companies/{companyId}/apiCredentials/{apiCredentialId}/generateClientKey".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [companyId,apiCredentialId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
