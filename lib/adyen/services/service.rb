module Adyen
  class AdyenService
    attr_accessor :service

    def initialize(service)
      @service = service
    end
  end
end
