require_relative '../service'
module Adyen


  class UsersMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def list_users(merchantId, headers: {} , queryParams: {})
      """
      Get a list of users
      """
      endpoint = "/merchants/{merchantId}/users".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      endpoint = endpoint + create_query_string(queryParams)
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_user_details(merchantId, userId, headers: {} )
      """
      Get user details
      """
      endpoint = "/merchants/{merchantId}/users/{userId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,userId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_user(request, merchantId, userId, headers: {} )
      """
      Update a user
      """
      endpoint = "/merchants/{merchantId}/users/{userId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,userId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_new_user(request, merchantId, headers: {} )
      """
      Create a new user
      """
      endpoint = "/merchants/{merchantId}/users".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
