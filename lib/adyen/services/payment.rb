require_relative 'payment/general_api'
require_relative 'payment/modifications_api'

module Adyen
  class Payment
    attr_accessor :service, :version

    DEFAULT_VERSION = 68
    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Payment'
      @client = client
      @version = version
    end

    def general_api
      @general_api ||= Adyen::GeneralApi.new(@client, @version)
    end

    def modifications_api
      @modifications_api ||= Adyen::ModificationsApi.new(@client, @version)
    end

  end
end
