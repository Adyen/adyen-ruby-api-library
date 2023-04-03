require_relative '../service'
module Adyen


  class HostedOnboardingApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "LegalEntityManagement"
      @client = client
      @version = version
    end

    def list_hosted_onboarding_page_themes(headers: {} )
      """
      Get a list of hosted onboarding page themes
      """
      endpoint = "/themes".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_onboarding_link_theme(id, headers: {} )
      """
      Get an onboarding link theme
      """
      endpoint = "/themes/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_link_to_adyenhosted_onboarding_page(request, id, headers: {} )
      """
      Get a link to an Adyen-hosted onboarding page
      """
      endpoint = "/legalEntities/{id}/onboardingLinks".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
