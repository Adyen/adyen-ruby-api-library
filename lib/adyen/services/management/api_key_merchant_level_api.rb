require_relative '../service'
module Adyen


  class APIKeyMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def generate_new_api_key(merchantId, apiCredentialId, headers: {} )
      """
      Generate new API key
      """
      endpoint = "/merchants/{merchantId}/apiCredentials/{apiCredentialId}/generateApiKey".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,apiCredentialId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
