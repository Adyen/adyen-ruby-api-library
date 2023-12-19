require_relative '../service'
module Adyen
  class PCIQuestionnairesApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'LegalEntityManagement')
    end

    def get_pci_questionnaire_details(id, headers: {})
      endpoint = '/legalEntities/{id}/pciQuestionnaires'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_pci_questionnaire(id, pciid, headers: {})
      endpoint = '/legalEntities/{id}/pciQuestionnaires/{pciid}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id, pciid)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def generate_pci_questionnaire(request, id, headers: {})
      endpoint = '/legalEntities/{id}/pciQuestionnaires/generatePciTemplates'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def sign_pci_questionnaire(request, id, headers: {})
      endpoint = '/legalEntities/{id}/pciQuestionnaires/signPciTemplates'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
