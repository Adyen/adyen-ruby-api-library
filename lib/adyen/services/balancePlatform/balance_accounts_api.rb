require_relative '../service'
module Adyen

  # NOTE: This class is auto generated by OpenAPI Generator
  # Ref: https://openapi-generator.tech
  #
  # Do not edit the class manually.
  class BalanceAccountsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BalancePlatform')
    end

    # Create a balance account
    def create_balance_account(request, headers: {})
      endpoint = '/balanceAccounts'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Create a sweep
    def create_sweep(request, balance_account_id, headers: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balance_account_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Delete a sweep
    def delete_sweep(balance_account_id, sweep_id, headers: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps/{sweepId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balance_account_id, sweep_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get all sweeps for a balance account
    def get_all_sweeps_for_balance_account(balance_account_id, headers: {}, query_params: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balance_account_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get all transaction rules for a balance account
    def get_all_transaction_rules_for_balance_account(id, headers: {})
      endpoint = '/balanceAccounts/{id}/transactionRules'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get a balance account
    def get_balance_account(id, headers: {})
      endpoint = '/balanceAccounts/{id}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get payment instruments linked to a balance account
    def get_payment_instruments_linked_to_balance_account(id, headers: {}, query_params: {})
      endpoint = '/balanceAccounts/{id}/paymentInstruments'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get a sweep
    def get_sweep(balance_account_id, sweep_id, headers: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps/{sweepId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balance_account_id, sweep_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Update a balance account
    def update_balance_account(request, id, headers: {})
      endpoint = '/balanceAccounts/{id}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Update a sweep
    def update_sweep(request, balance_account_id, sweep_id, headers: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps/{sweepId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balance_account_id, sweep_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
