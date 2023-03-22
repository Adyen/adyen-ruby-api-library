module Adyen


  class OrdersApi
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Checkout"
      @client = client
      @version = version
    end

    def orders(request,  headers={})
      """
      Create an order
      """
      endpoint = "/orders".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      action = { method: "POST", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def cancel_order(request,  headers={})
      """
      Cancel an order
      """
      endpoint = "/orders/cancel".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      action = { method: "POST", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def get_balance_of_gift_card(request,  headers={})
      """
      Get the balance of a gift card
      """
      endpoint = "/paymentMethods/balance".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      action = { method: "POST", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
