require_relative 'service'

module Adyen
  class BinLookup < Service
    attr_accessor :version
    DEFAULT_VERSION = 50

    def initialize(client, version = DEFAULT_VERSION)
      service = 'BinLookup'
      method_names = [
        :get_3ds_availability,
        :get_cost_estimate
      ]

      super(client, version, service, method_names)
    end
  end
end
