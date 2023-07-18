require_relative 'legalEntityManagement/business_lines_api'
require_relative 'legalEntityManagement/documents_api'
require_relative 'legalEntityManagement/hosted_onboarding_api'
require_relative 'legalEntityManagement/legal_entities_api'
require_relative 'legalEntityManagement/pci_questionnaires_api'
require_relative 'legalEntityManagement/terms_of_service_api'
require_relative 'legalEntityManagement/transfer_instruments_api'

module Adyen
  class LegalEntityManagement
    attr_accessor :service, :version

    DEFAULT_VERSION = 3
    def initialize(client, version = DEFAULT_VERSION)
      @service = 'LegalEntityManagement'
      @client = client
      @version = version
    end

    def business_lines_api
      @business_lines_api ||= Adyen::BusinessLinesApi.new(@client, @version)
    end

    def documents_api
      @documents_api ||= Adyen::DocumentsApi.new(@client, @version)
    end

    def hosted_onboarding_api
      @hosted_onboarding_api ||= Adyen::HostedOnboardingApi.new(@client, @version)
    end

    def legal_entities_api
      @legal_entities_api ||= Adyen::LegalEntitiesApi.new(@client, @version)
    end

    def pci_questionnaires_api
      @pci_questionnaires_api ||= Adyen::PCIQuestionnairesApi.new(@client, @version)
    end

    def terms_of_service_api
      @terms_of_service_api ||= Adyen::TermsOfServiceApi.new(@client, @version)
    end

    def transfer_instruments_api
      @transfer_instruments_api ||= Adyen::TransferInstrumentsApi.new(@client, @version)
    end

  end
end
