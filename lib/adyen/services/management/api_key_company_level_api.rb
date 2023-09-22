require_relative '../service'
module Adyen
  class APIKeyCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def generate_new_api_key(company_id, api_credential_id, headers: {})
      endpoint = '/companies/{companyId}/apiCredentials/{apiCredentialId}/generateApiKey'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id, api_credential_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
