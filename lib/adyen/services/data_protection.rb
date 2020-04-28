require_relative 'service'

module Adyen
  class DataProtection < Service
    attr_accessor :version
    DEFAULT_VERSION = 1

    def initialize(client, version = DEFAULT_VERSION)
      service = 'DataProtectionService'
      method_names = [
        :request_subject_erasure
      ]

      super(client, version, service, method_names)
    end
  end
end
