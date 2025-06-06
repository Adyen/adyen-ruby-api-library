require_relative '../service'
module Adyen

  # NOTE: This class is auto generated by OpenAPI Generator
  # Ref: https://openapi-generator.tech
  #
  # Do not edit the class manually.
  class PlatformApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BalancePlatform')
    end

    # Get all account holders under a balance platform
    def get_all_account_holders_under_balance_platform(id, headers: {}, query_params: {})
      endpoint = '/balancePlatforms/{id}/accountHolders'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get all transaction rules for a balance platform
    def get_all_transaction_rules_for_balance_platform(id, headers: {})
      endpoint = '/balancePlatforms/{id}/transactionRules'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get a balance platform
    def get_balance_platform(id, headers: {})
      endpoint = '/balancePlatforms/{id}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
