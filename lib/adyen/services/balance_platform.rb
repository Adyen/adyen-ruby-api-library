require_relative "service"

module Adyen
  class BalancePlatform < Service
    attr_accessor :version
    DEFAULT_VERSION = 1

    def initialize(client, version = DEFAULT_VERSION)
      @service = "BalancePlatform"
      @client = client
      @version = version
    end

    def create_legal_entity(request)
      @client.call_adyen_api(@service, "legalEntities", request, {}, @version)
    end

    def get_legal_entity(legal_entity_id)
      action = { method: 'get', url: "legalEntities/" + legal_entity_id }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def update_legal_entity(request, legal_entity_id)
      action = { method: 'patch', url: "legalEntities/" + legal_entity_id }

      @client.call_adyen_api(@service, action, request, {}, @version)
    end

    def create_account_holder(request)
      @client.call_adyen_api(@service, "accountHolders", request, {}, @version)
    end

    def update_account_holder(request, account_holder_id)
      action = { method: 'patch', url: "accountHolders/" + account_holder_id }

      @client.call_adyen_api(@service, action, request, {}, @version)
    end

    def get_account_holder(account_holder_id)
      action = { method: 'get', url: "accountHolders/" + account_holder_id }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def create_balance_account(request)
      @client.call_adyen_api(@service, "balanceAccounts", request, {}, @version)
    end

    def update_balance_account(request, balance_account_id)
      action = { method: 'patch', url: "balanceAccounts/" + balance_account_id }

      @client.call_adyen_api(@service, action, request, {}, @version)
    end

    def get_balance_account(balance_account_id)
      action = { method: 'get', url: "balanceAccounts/" + balance_account_id }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def create_payment_instrument(request)
      @client.call_adyen_api(@service, "paymentInstruments", request, {}, @version)
    end

    def update_payment_instrument(request, payment_instrument_id)
      action = { method: 'patch', url: "paymentInstruments/" + payment_instrument_id }

      @client.call_adyen_api(@service, action, request, {}, @version)
    end

    def get_payment_instrument(payment_instrument_id)
      action = { method: 'get', url: "paymentInstruments/" + payment_instrument_id }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def get_payment_instrument_pin(request)
      @client.call_adyen_api(@service, "pins/reveal", request, {}, @version)
    end

    def get_payment_instrument_information(request)
      @client.call_adyen_api(@service, "paymentInstruments/reveal", request, {}, @version)
    end

    def create_transfer_instrument(request)
      @client.call_adyen_api(@service, "transferInstruments", request, {}, @version)
    end

    def update_transfer_instrument(request, transfer_instrument_id)
      action = { method: 'patch', url: "transferInstruments/" + transfer_instrument_id }

      @client.call_adyen_api(@service, action, request, {}, @version)
    end

    def get_transfer_instrument(transfer_instrument_id)
      action = { method: 'get', url: "transferInstruments/" + transfer_instrument_id }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def delete_transfer_instrument(transfer_instrument_id)
      action = { method: 'delete', url: "transferInstruments/" + transfer_instrument_id }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def create_document(request)
      @client.call_adyen_api(@service, "documents", request, {}, @version)
    end

    def update_document(request, document_id)
      action = { method: 'patch', url: "documents/" + document_id }

      @client.call_adyen_api(@service, action, request, {}, @version)
    end

    def get_document(document_id)
      action = { method: 'get', url: "documents/" + document_id }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def delete_document(document_id)
      action = { method: 'delete', url: "documents/" + document_id }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def get_public_key(purpose)
      request_params = {
        "purpose" => purpose
      }
      action = { method: 'get', url: "publicKey"}

      @client.call_adyen_api(@service, action, request_params, {}, @version)
    end
  end
end
