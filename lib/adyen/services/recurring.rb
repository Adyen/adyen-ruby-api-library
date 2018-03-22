module Adyen
  class Recurring
    def initialize(client)
      @client = client
      @service = 'Recurring'
    end

    def list_recurring_details(request)
      action = 'listRecurringDetails'
      @client.call_adyen_api(@service, action, request)
    end

    def disable(request)
      action = 'disable'
      @client.call_adyen_api(@service, action, request)
    end

    def store_token(request)
      action = 'storeToken'
      @client.call_adyen_api(@service, action, request)
    end

    def schedule_account_updater(request)
      action = 'scheduleAccountUpdater'
      @client.call_adyen_api(@service, action, request)
    end
  end
end
