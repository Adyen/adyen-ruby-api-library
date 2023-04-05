require_relative '../service'
module Adyen


  class PlatformApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "BalancePlatform"
      @client = client
      @version = version
    end

    def get_balance_platform(id, headers: {} )
      """
      Get a balance platform
      """
      endpoint = "/balancePlatforms/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_all_account_holders_under_balance_platform(id, headers: {} , queryParams: {})
      """
      Get all account holders under a balance platform
      """
      endpoint = "/balancePlatforms/{id}/accountHolders".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

  end
end
