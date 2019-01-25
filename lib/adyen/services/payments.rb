require_relative 'service'

module Adyen
  class Payments < Service
    attr_accessor :version
    DEFAULT_VERSION = 40

    def initialize(client, version = DEFAULT_VERSION)
      service = 'Payment'
      method_names = [
        :authorise,
        :authorise3d,
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
