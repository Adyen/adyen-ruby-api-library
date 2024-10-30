require_relative 'checkout/donations_api'
require_relative 'checkout/modifications_api'
require_relative 'checkout/orders_api'
require_relative 'checkout/payment_links_api'
require_relative 'checkout/payments_api'
require_relative 'checkout/recurring_api'
require_relative 'checkout/utility_api'

module Adyen
  class Checkout
    attr_accessor :service, :version

    DEFAULT_VERSION = 71
    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Checkout'
      @client = client
      @version = version
    end

    def donations_api
      @donations_api ||= Adyen::DonationsApi.new(@client, @version)
    end

    def modifications_api
      @modifications_api ||= Adyen::ModificationsApi.new(@client, @version)
    end

    def orders_api
      @orders_api ||= Adyen::OrdersApi.new(@client, @version)
    end

    def payment_links_api
      @payment_links_api ||= Adyen::PaymentLinksApi.new(@client, @version)
    end

    def payments_api
      @payments_api ||= Adyen::PaymentsApi.new(@client, @version)
    end

    def recurring_api
      @recurring_api ||= Adyen::RecurringApi.new(@client, @version)
    end

    def utility_api
      @utility_api ||= Adyen::UtilityApi.new(@client, @version)
    end

  end
end
