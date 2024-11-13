require_relative '../service'
module Adyen

  # NOTE: This class is auto generated by OpenAPI Generator
  # Ref: https://openapi-generator.tech
  #
  # Do not edit the class manually.
  class TransactionRulesApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BalancePlatform')
    end

    # Create a transaction rule
    def create_transaction_rule(request, headers: {})
      endpoint = '/transactionRules'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Delete a transaction rule
    def delete_transaction_rule(transaction_rule_id, headers: {})
      endpoint = '/transactionRules/{transactionRuleId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, transaction_rule_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get a transaction rule
    def get_transaction_rule(transaction_rule_id, headers: {})
      endpoint = '/transactionRules/{transactionRuleId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, transaction_rule_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Update a transaction rule
    def update_transaction_rule(request, transaction_rule_id, headers: {})
      endpoint = '/transactionRules/{transactionRuleId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, transaction_rule_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
