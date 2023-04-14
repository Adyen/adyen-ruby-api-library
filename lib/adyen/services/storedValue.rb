require_relative './service'
module Adyen


  class StoredValue < Service
    attr_accessor :service, :version
    DEFAULT_VERSION = 46

    def initialize(client, version = DEFAULT_VERSION)
      @service = "StoredValue"
      @client = client
      @version = version
    end

    def change_status(request, headers: {} )
      """
      Changes the status of the payment method.
      """
      endpoint = "/changeStatus".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def check_balance(request, headers: {} )
      """
      Checks the balance.
      """
      endpoint = "/checkBalance".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def issue(request, headers: {} )
      """
      Issues a new card.
      """
      endpoint = "/issue".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def load(request, headers: {} )
      """
      Loads the payment method.
      """
      endpoint = "/load".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def merge_balance(request, headers: {} )
      """
      Merge the balance of two cards.
      """
      endpoint = "/mergeBalance".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def void_transaction(request, headers: {} )
      """
      Voids a transaction.
      """
      endpoint = "/voidTransaction".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
