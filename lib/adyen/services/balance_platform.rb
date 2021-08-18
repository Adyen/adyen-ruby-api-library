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

    def get_legal_entity(legalEntityId)
      action = { method: 'get', url: "legalEntities/" + legalEntityId }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end

    def update_legal_entity(request, legalEntityId)
      action = { method: 'patch', url: "legalEntities/" + legalEntityId }

      @client.call_adyen_api(@service, action, request, {}, @version)
    end

    def create_account_holder(request)
      @client.call_adyen_api(@service, "accountHolders", request, {}, @version)
    end

    def update_account_holder(request, accountHolderId)
      action = { method: 'patch', url: "accountHolders/" + accountHolderId }

      @client.call_adyen_api(@service, action, request, {}, @version)
    end

    def get_account_holder(accountHolderId)
      action = { method: 'get', url: "accountHolders/" + accountHolderId }

      @client.call_adyen_api(@service, action, {}, {}, @version)
    end
  end
end
