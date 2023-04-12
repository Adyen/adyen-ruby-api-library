require_relative './service'
module Adyen


  class BinLookup < Service
    attr_accessor :service, :version
    DEFAULT_VERSION = 52

    def initialize(client, version = DEFAULT_VERSION)
      @service = "BinLookup"
      @client = client
      @version = version
    end

    def get3ds_availability(request, headers: {} )
      """
      Check if 3D Secure is available
      """
      endpoint = "/get3dsAvailability".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_cost_estimate(request, headers: {} )
      """
      Get a fees cost estimate
      """
      endpoint = "/getCostEstimate".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
