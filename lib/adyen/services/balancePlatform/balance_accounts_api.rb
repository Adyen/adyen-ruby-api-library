require_relative '../service'
module Adyen
  class BalanceAccountsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BalancePlatform')
    end

    def delete_sweep(balanceAccountId, sweepId, headers: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps/{sweepId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balanceAccountId, sweepId)

      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_all_sweeps_for_balance_account(balanceAccountId, headers: {}, queryParams: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balanceAccountId)
      endpoint += create_query_string(queryParams)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_sweep(balanceAccountId, sweepId, headers: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps/{sweepId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balanceAccountId, sweepId)

      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_balance_account(id, headers: {})
      endpoint = '/balanceAccounts/{id}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)

      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_all_payment_instruments_for_balance_account(id, headers: {}, queryParams: {})
      endpoint = '/balanceAccounts/{id}/paymentInstruments'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      endpoint += create_query_string(queryParams)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_sweep(request, balanceAccountId, sweepId, headers: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps/{sweepId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balanceAccountId, sweepId)

      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_balance_account(request, id, headers: {})
      endpoint = '/balanceAccounts/{id}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)

      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_balance_account(request, headers: {})
      endpoint = '/balanceAccounts'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_sweep(request, balanceAccountId, headers: {})
      endpoint = '/balanceAccounts/{balanceAccountId}/sweeps'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, balanceAccountId)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
