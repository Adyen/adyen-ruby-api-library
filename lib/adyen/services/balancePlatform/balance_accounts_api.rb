require_relative '../service'
module Adyen


  class BalanceAccountsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "BalancePlatform"
      @client = client
      @version = version
    end

    def delete_sweep(balanceAccountId, sweepId, headers: {} )
      """
      Delete a sweep
      """
      endpoint = "/balanceAccounts/{balanceAccountId}/sweeps/{sweepId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [balanceAccountId,sweepId]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_all_sweeps_for_balance_account(balanceAccountId, headers: {} , queryParams: {})
      """
      Get all sweeps for a balance account
      """
      endpoint = "/balanceAccounts/{balanceAccountId}/sweeps".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [balanceAccountId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_sweep(balanceAccountId, sweepId, headers: {} )
      """
      Get a sweep
      """
      endpoint = "/balanceAccounts/{balanceAccountId}/sweeps/{sweepId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [balanceAccountId,sweepId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_balance_account(id, headers: {} )
      """
      Get a balance account
      """
      endpoint = "/balanceAccounts/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_all_payment_instruments_for_balance_account(id, headers: {} , queryParams: {})
      """
      Get all payment instruments for a balance account
      """
      endpoint = "/balanceAccounts/{id}/paymentInstruments".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_sweep(request, balanceAccountId, sweepId, headers: {} )
      """
      Update a sweep
      """
      endpoint = "/balanceAccounts/{balanceAccountId}/sweeps/{sweepId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [balanceAccountId,sweepId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_balance_account(request, id, headers: {} )
      """
      Update a balance account
      """
      endpoint = "/balanceAccounts/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_balance_account(request, headers: {} )
      """
      Create a balance account
      """
      endpoint = "/balanceAccounts".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_sweep(request, balanceAccountId, headers: {} )
      """
      Create a sweep
      """
      endpoint = "/balanceAccounts/{balanceAccountId}/sweeps".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [balanceAccountId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
