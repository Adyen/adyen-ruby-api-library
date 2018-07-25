require_relative 'service'

module Adyen
  class Payouts < Service
    attr_accessor :version
    DEFAULT_VERSION = 30

    def initialize(client, version = DEFAULT_VERSION)
      service = 'Payout'
      method_names = [
        :store_detail,
        :store_detail_and_submit_third_party,
        :submit_third_party,
        :confirm_third_party,
        :decline_third_party
      ]

      super(client, version, service, method_names)
    end
  end
end
