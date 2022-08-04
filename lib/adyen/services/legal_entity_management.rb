require_relative "service"

module Adyen
  class LegalEntityManagement < Service
    attr_accessor :version
    DEFAULT_VERSION = 1

    def initialize(client, version = DEFAULT_VERSION)
      @service = "LegalEntityManagement"
      @client = client
      @version = version
    end

    def create_legal_entity(request, headers = {})
      @client.call_adyen_api(@service, "legalEntities", request, headers, @version)
    end

    def get_legal_entity(legal_entity_id, headers = {})
      action = { method: 'get', url: "legalEntities/" + legal_entity_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_legal_entity(request, legal_entity_id, headers = {})
      action = { method: 'patch', url: "legalEntities/" + legal_entity_id }

      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_transfer_instrument(request, headers = {})
      @client.call_adyen_api(@service, "transferInstruments", request, headers, @version)
    end

    def update_transfer_instrument(request, transfer_instrument_id, headers = {})
      action = { method: 'patch', url: "transferInstruments/" + transfer_instrument_id }

      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_transfer_instrument(transfer_instrument_id, headers = {})
      action = { method: 'get', url: "transferInstruments/" + transfer_instrument_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def delete_transfer_instrument(transfer_instrument_id, headers = {})
      action = { method: 'delete', url: "transferInstruments/" + transfer_instrument_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_document(request, headers = {})
      @client.call_adyen_api(@service, "documents", request, headers, @version)
    end

    def update_document(request, document_id, headers = {})
      action = { method: 'patch', url: "documents/" + document_id }

      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_document(document_id, headers = {})
      action = { method: 'get', url: "documents/" + document_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def delete_document(document_id, headers = {})
      action = { method: 'delete', url: "documents/" + document_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_business_line(request, headers = {})
      @client.call_adyen_api(@service, "businessLines", request, headers, @version)
    end

    def get_business_line(business_line_id, headers = {})
      action = { method: 'get', url: "businessLines/" + business_line_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_business_line(request, business_line_id, headers = {})
      action = { method: 'patch', url: "businessLines/" + business_line_id }

      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def delete_business_line(business_line_id, headers = {})
      action = { method: 'delete', url: "businessLines/" + business_line_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_legal_entity_business_lines(legal_entity_id, headers = {})
      action = { method: 'get', url: "legalEntities/#{legal_entity_id}/businessLines" }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end
  end
end
