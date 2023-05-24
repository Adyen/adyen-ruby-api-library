require_relative '../service'
module Adyen
  class TransactionRulesApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = 'BalancePlatform'
      @client = client
      @version = version
    end

    def delete_transaction_rule(transactionRuleId, headers: {})
      endpoint = '/transactionRules/{transactionRuleId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, transactionRuleId)

      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_transaction_rule(transactionRuleId, headers: {})
      endpoint = '/transactionRules/{transactionRuleId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, transactionRuleId)

      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_transaction_rule(request, transactionRuleId, headers: {})
      endpoint = '/transactionRules/{transactionRuleId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, transactionRuleId)

      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_transaction_rule(request, headers: {})
      endpoint = '/transactionRules'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
