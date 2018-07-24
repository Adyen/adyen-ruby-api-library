require_relative 'service'

module Adyen
  class CheckoutUtility < Service
    DEFAULT_VERSION = 1

    def initialize(client, version = DEFAULT_VERSION)
      service = 'CheckoutUtility'
      method_names = [
        :origin_keys
      ]

      super(client, version, service, method_names)
    end
  end
end
