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

    def create_account_holder(request, headers = {})
      @client.call_adyen_api(@service, "accountHolders", request, headers, @version)
    end

    def update_account_holder(request, account_holder_id, headers = {})
      action = { method: 'patch', url: "accountHolders/" + account_holder_id }

      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_account_holder(account_holder_id, headers = {})
      action = { method: 'get', url: "accountHolders/" + account_holder_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_balance_account(request, headers = {})
      @client.call_adyen_api(@service, "balanceAccounts", request, headers, @version)
    end

    def update_balance_account(request, balance_account_id, headers = {})
      action = { method: 'patch', url: "balanceAccounts/" + balance_account_id }

      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_balance_account(balance_account_id, headers = {})
      action = { method: 'get', url: "balanceAccounts/" + balance_account_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_payment_instrument(request, headers = {})
      @client.call_adyen_api(@service, "paymentInstruments", request, headers, @version)
    end

    def update_payment_instrument(request, payment_instrument_id, headers = {})
      action = { method: 'patch', url: "paymentInstruments/" + payment_instrument_id }

      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_payment_instrument(payment_instrument_id, headers = {})
      action = { method: 'get', url: "paymentInstruments/" + payment_instrument_id }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_payment_instrument_pin(request, headers = {})
      @client.call_adyen_api(@service, "pins/reveal", request, headers, @version)
    end

    def get_payment_instrument_information(request, headers = {})
      @client.call_adyen_api(@service, "paymentInstruments/reveal", request, headers, @version)
    end

    def create_sweep(request, balance_account_id, headers = {})
      @client.call_adyen_api(@service, "balanceAccounts/#{balance_account_id}/sweeps", request, headers, @version)
    end

    def update_sweep(request, balance_account_id, sweep_id, headers = {})
      action = { method: 'patch', url: "balanceAccounts/#{balance_account_id}/sweeps/#{sweep_id}" }

      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_sweep(balance_account_id, sweep_id, headers = {})
      action = { method: 'get', url: "balanceAccounts/#{balance_account_id}/sweeps/#{sweep_id}" }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def delete_sweep(balance_account_id, sweep_id, headers = {})
      action = { method: 'delete', url: "balanceAccounts/#{balance_account_id}/sweeps/#{sweep_id}" }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_sweeps(balance_account_id, headers = {})
      action = { method: 'get', url: "balanceAccounts/#{balance_account_id}/sweeps" }

      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def create_registered_device(request, headers = {})
      @client.call_adyen_api(@service, "registeredDevices", request, headers, @version)
    end

    def update_registered_device(request, registered_device_id, headers = {})
      action = { method: 'patch', url: "registeredDevices/#{registered_device_id}" }

      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_public_key(purpose, headers = {})
      request_params = {
        "purpose" => purpose
      }
      action = { method: 'get', url: "publicKey"}

      @client.call_adyen_api(@service, action, request_params, headers, @version)
    end
  end
end
