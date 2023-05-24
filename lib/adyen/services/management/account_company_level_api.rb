require_relative '../service'
module Adyen
  class AccountCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def list_company_accounts(headers: {} , queryParams: {})
      endpoint = "/companies".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % []
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_company_account(companyId, headers: {} )
      endpoint = "/companies/{companyId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [companyId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_merchant_accounts(companyId, headers: {} , queryParams: {})
      endpoint = "/companies/{companyId}/merchants".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = endpoint % [companyId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
