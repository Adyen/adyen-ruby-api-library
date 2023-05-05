require_relative '../service'
module Adyen


  class TransferInstrumentsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "LegalEntityManagement"
      @client = client
      @version = version
    end

    def delete_transfer_instrument(id, headers: {} )
      """
      Delete a transfer instrument
      """
      endpoint = "/transferInstruments/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_transfer_instrument(id, headers: {} )
      """
      Get a transfer instrument
      """
      endpoint = "/transferInstruments/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_transfer_instrument(request, id, headers: {} )
      """
      Update a transfer instrument
      """
      endpoint = "/transferInstruments/{id}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [id]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_transfer_instrument(request, headers: {} )
      """
      Create a transfer instrument
      """
      endpoint = "/transferInstruments".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
