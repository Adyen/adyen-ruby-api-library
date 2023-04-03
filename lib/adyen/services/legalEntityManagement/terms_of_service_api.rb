require_relative '../service'
module Adyen


  class TermsOfServiceApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "LegalEntityManagement"
      @client = client
      @version = version
    end

    def get_terms_of_service_information_for_legal_entity(id, headers: {} )
      """
      Get Terms of Service information for a legal entity
      """
      endpoint = "/legalEntities/{id}/termsOfServiceAcceptanceInfos".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terms_of_service_status(id, headers: {} )
      """
      Get Terms of Service status
      """
      endpoint = "/legalEntities/{id}/termsOfServiceStatus".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def accept_terms_of_service(request, id, termsofservicedocumentid, headers: {} )
      """
      Accept Terms of Service
      """
      endpoint = "/legalEntities/{id}/termsOfService/{termsofservicedocumentid}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [idtermsofservicedocumentid]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_terms_of_service_document(request, id, headers: {} )
      """
      Get Terms of Service document
      """
      endpoint = "/legalEntities/{id}/termsOfService".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
