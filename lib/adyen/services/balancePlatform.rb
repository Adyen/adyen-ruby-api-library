require_relative 'balancePlatform/account_holders_api'
require_relative 'balancePlatform/balance_accounts_api'
require_relative 'balancePlatform/bank_account_validation_api'
require_relative 'balancePlatform/card_orders_api'
require_relative 'balancePlatform/grant_accounts_api'
require_relative 'balancePlatform/grant_offers_api'
require_relative 'balancePlatform/manage_card_pin_api'
require_relative 'balancePlatform/network_tokens_api'
require_relative 'balancePlatform/payment_instrument_groups_api'
require_relative 'balancePlatform/payment_instruments_api'
require_relative 'balancePlatform/platform_api'
require_relative 'balancePlatform/transaction_rules_api'
require_relative 'balancePlatform/transfer_routes_api'

module Adyen
  class BalancePlatform
    attr_accessor :service, :version

    DEFAULT_VERSION = 2
    def initialize(client, version = DEFAULT_VERSION)
      @service = 'BalancePlatform'
      @client = client
      @version = version
    end

    def account_holders_api
      @account_holders_api ||= Adyen::AccountHoldersApi.new(@client, @version)
    end

    def balance_accounts_api
      @balance_accounts_api ||= Adyen::BalanceAccountsApi.new(@client, @version)
    end

    def bank_account_validation_api
      @bank_account_validation_api ||= Adyen::BankAccountValidationApi.new(@client, @version)
    end

    def card_orders_api
      @card_orders_api ||= Adyen::CardOrdersApi.new(@client, @version)
    end

    def grant_accounts_api
      @grant_accounts_api ||= Adyen::GrantAccountsApi.new(@client, @version)
    end

    def grant_offers_api
      @grant_offers_api ||= Adyen::GrantOffersApi.new(@client, @version)
    end

    def manage_card_pin_api
      @manage_card_pin_api ||= Adyen::ManageCardPINApi.new(@client, @version)
    end

    def network_tokens_api
      @network_tokens_api ||= Adyen::NetworkTokensApi.new(@client, @version)
    end

    def payment_instrument_groups_api
      @payment_instrument_groups_api ||= Adyen::PaymentInstrumentGroupsApi.new(@client, @version)
    end

    def payment_instruments_api
      @payment_instruments_api ||= Adyen::PaymentInstrumentsApi.new(@client, @version)
    end

    def platform_api
      @platform_api ||= Adyen::PlatformApi.new(@client, @version)
    end

    def transaction_rules_api
      @transaction_rules_api ||= Adyen::TransactionRulesApi.new(@client, @version)
    end

    def transfer_routes_api
      @transfer_routes_api ||= Adyen::TransferRoutesApi.new(@client, @version)
    end

  end
end
