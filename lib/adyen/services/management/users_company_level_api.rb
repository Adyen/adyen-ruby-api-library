require_relative '../service'
module Adyen
  class UsersCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Management'
      @client = client
      @version = version
    end

    def list_users(companyId, headers: {}, queryParams: {})
      endpoint = '/companies/{companyId}/users'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, companyId)
      endpoint += create_query_string(queryParams)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_user_details(companyId, userId, headers: {})
      endpoint = '/companies/{companyId}/users/{userId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, companyId, userId)

      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_user_details(request, companyId, userId, headers: {})
      endpoint = '/companies/{companyId}/users/{userId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, companyId, userId)

      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_new_user(request, companyId, headers: {})
      endpoint = '/companies/{companyId}/users'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, companyId)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
