require_relative 'service'

module Adyen
  class Recurring < Service
    attr_accessor :version
    DEFAULT_VERSION = 49

    def initialize(client, version = DEFAULT_VERSION)
      service = 'Recurring'
      method_names = [
        :list_recurring_details,
        :disable,
        :store_token,
        :schedule_account_updater
      ]

      super(client, version, service, method_names)
    end
  end
end
