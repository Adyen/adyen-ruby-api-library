require_relative '../service'
module Adyen


  class DocumentsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "LegalEntityManagement"
      @client = client
      @version = version
    end

    def delete_document(id, headers: {} )
      """
      Delete a document
      """
      endpoint = "/documents/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_document(id, headers: {} )
      """
      Get a document
      """
      endpoint = "/documents/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_document(request, id, headers: {} )
      """
      Update a document
      """
      endpoint = "/documents/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def upload_document_for_verification_checks(request, headers: {} )
      """
      Upload a document for verification checks
      """
      endpoint = "/documents".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
