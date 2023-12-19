require_relative '../service'
module Adyen
  class TermsOfServiceApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'LegalEntityManagement')
    end

    def get_terms_of_service_information_for_legal_entity(id, headers: {})
      endpoint = '/legalEntities/{id}/termsOfServiceAcceptanceInfos'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terms_of_service_status(id, headers: {})
      endpoint = '/legalEntities/{id}/termsOfServiceStatus'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def accept_terms_of_service(request, id, termsofservicedocumentid, headers: {})
      endpoint = '/legalEntities/{id}/termsOfService/{termsofservicedocumentid}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id, termsofservicedocumentid)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_terms_of_service_document(request, id, headers: {})
      endpoint = '/legalEntities/{id}/termsOfService'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
