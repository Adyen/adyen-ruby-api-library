require_relative 'service'

module Adyen
  class Recurring < Service
    attr_accessor :version
    DEFAULT_VERSION = 25

    def initialize(client, version = DEFAULT_VERSION)
      service = 'Recurring'
      method_names = [
        :list_recurring_details,
        :disable,
        :store_token
      ]

      super(client, version, service, method_names)
    end
  end
end
