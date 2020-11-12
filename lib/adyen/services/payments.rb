require_relative "service"

module Adyen
  class Payments < Service
    attr_accessor :version
    DEFAULT_VERSION = 50

    def initialize(client, version = DEFAULT_VERSION)
      service = "Payment"
      method_names = [
        :authorise,
        :authorise3d,
        :authorise3ds2,
        :capture,
        :cancel,
        :refund,
        :cancel_or_refund,
        :adjust_authorisation,
        :donate,
      ]
      with_application_info = [
        :authorise,
        :authorise3d,
        :authorise3ds2,
      ]

      super(client, version, service, method_names, with_application_info)
    end
  end
end
