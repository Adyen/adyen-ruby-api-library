require_relative './service'
module Adyen


  class Recurring < Service
    attr_accessor :service, :version
    DEFAULT_VERSION = 68

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Recurring"
      @client = client
      @version = version
    end

    def create_permit(request, headers: {} )
      """
      Create new permits linked to a recurring contract.
      """
      endpoint = "/createPermit".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def disable(request, headers: {} )
      """
      Disable stored payment details
      """
      endpoint = "/disable".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def disable_permit(request, headers: {} )
      """
      Disable an existing permit.
      """
      endpoint = "/disablePermit".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def list_recurring_details(request, headers: {} )
      """
      Get stored payment details
      """
      endpoint = "/listRecurringDetails".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def notify_shopper(request, headers: {} )
      """
      Ask issuer to notify the shopper
      """
      endpoint = "/notifyShopper".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def schedule_account_updater(request, headers: {} )
      """
      Schedule running the Account Updater
      """
      endpoint = "/scheduleAccountUpdater".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
