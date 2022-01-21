require_relative "service"

module Adyen
  class Payments < Service
    attr_accessor :version
    DEFAULT_VERSION = 64

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
        :get_authentication_result,
        :technical_cancel,
        :void_pending_refund,
        :retrieve_3ds2_result
      ]
      with_application_info = [
        :authorise,
        :authorise3d,
        :authorise3ds2
      ]

      super(client, version, service, method_names, with_application_info)
    end
  end
end
