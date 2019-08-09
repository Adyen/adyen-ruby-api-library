require_relative 'service'

module Adyen
  class Payments < Service
    attr_accessor :version
    DEFAULT_VERSION = 49

    def initialize(client, version = DEFAULT_VERSION)
      service = 'Payment'
      method_names = [
        :authorise,
        :authorise3d,
        :authorise3ds2,
        :capture,
        :cancel,
        :refund,
        :cancel_or_refund,
        :adjust_authorisation
      ]

      super(client, version, service, method_names)
    end
  end
end
