require_relative '../service'
module Adyen
  class TaxEDeliveryConsentApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'LegalEntityManagement')
    end

    def check_status_of_consent_for_electronic_delivery_of_tax_forms(id, headers: {})
      endpoint = '/legalEntities/{id}/checkTaxElectronicDeliveryConsent'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def set_consent_status_for_electronic_delivery_of_tax_forms(request, id, headers: {})
      endpoint = '/legalEntities/{id}/setTaxElectronicDeliveryConsent'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
