require_relative '../service'
module Adyen


  class LegalEntitiesApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "LegalEntityManagement"
      @client = client
      @version = version
    end

    def get_legal_entity(id, headers: {} )
      """
      Get a legal entity
      """
      endpoint = "/legalEntities/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_all_business_lines_under_legal_entity(id, headers: {} )
      """
      Get all business lines under a legal entity
      """
      endpoint = "/legalEntities/{id}/businessLines".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_legal_entity(request, id, headers: {} )
      """
      Update a legal entity
      """
      endpoint = "/legalEntities/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_legal_entity(request, headers: {} )
      """
      Create a legal entity
      """
      endpoint = "/legalEntities".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def check_legal_entitys_verification_errors(id, headers: {} )
      """
      Check a legal entity's verification errors
      """
      endpoint = "/legalEntities/{id}/checkVerificationErrors".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
