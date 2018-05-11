module Adyen
  class Recurring
    attr_accessor :version

    def initialize(client, version = 25)
      @client = client
      @version = version
      @service = 'Recurring'
    end

    def list_recurring_details(request)
      action = 'listRecurringDetails'
      @client.call_adyen_api(@service, action, request, @version)
    end

    def disable(request)
      action = 'disable'
      @client.call_adyen_api(@service, action, request, @version)
    end
  end
end
