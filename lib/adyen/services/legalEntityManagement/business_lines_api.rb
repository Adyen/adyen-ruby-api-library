require_relative '../service'
module Adyen


  class BusinessLinesApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "LegalEntityManagement"
      @client = client
      @version = version
    end

    def delete_business_line(id, headers: {} )
      """
      Delete a business line
      """
      endpoint = "/businessLines/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_business_line(id, headers: {} )
      """
      Get a business line
      """
      endpoint = "/businessLines/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_business_line(request, id, headers: {} )
      """
      Update a business line
      """
      endpoint = "/businessLines/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_business_line(request, headers: {} )
      """
      Create a business line
      """
      endpoint = "/businessLines".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
