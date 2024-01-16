require_relative '../service'
module Adyen
  class AndroidFilesCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def list_android_apps(company_id, headers: {}, query_params: {})
      endpoint = '/companies/{companyId}/androidApps'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_android_app(company_id, id, headers: {})
      endpoint = '/companies/{companyId}/androidApps/{id}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id, id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_android_certificates(company_id, headers: {}, query_params: {})
      endpoint = '/companies/{companyId}/androidCertificates'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def upload_android_app(company_id, headers: {})
      endpoint = '/companies/{companyId}/androidApps'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
