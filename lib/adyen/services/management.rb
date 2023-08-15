require_relative 'management/api_credentials_company_level_api'
require_relative 'management/api_credentials_merchant_level_api'
require_relative 'management/api_key_company_level_api'
require_relative 'management/api_key_merchant_level_api'
require_relative 'management/account_company_level_api'
require_relative 'management/account_merchant_level_api'
require_relative 'management/account_store_level_api'
require_relative 'management/allowed_origins_company_level_api'
require_relative 'management/allowed_origins_merchant_level_api'
require_relative 'management/client_key_company_level_api'
require_relative 'management/client_key_merchant_level_api'
require_relative 'management/my_api_credential_api'
require_relative 'management/payment_methods_merchant_level_api'
require_relative 'management/payout_settings_merchant_level_api'
require_relative 'management/split_configuration_merchant_level_api'
require_relative 'management/terminal_actions_company_level_api'
require_relative 'management/terminal_actions_terminal_level_api'
require_relative 'management/terminal_orders_company_level_api'
require_relative 'management/terminal_orders_merchant_level_api'
require_relative 'management/terminal_settings_company_level_api'
require_relative 'management/terminal_settings_merchant_level_api'
require_relative 'management/terminal_settings_store_level_api'
require_relative 'management/terminal_settings_terminal_level_api'
require_relative 'management/terminals_terminal_level_api'
require_relative 'management/users_company_level_api'
require_relative 'management/users_merchant_level_api'
require_relative 'management/webhooks_company_level_api'
require_relative 'management/webhooks_merchant_level_api'

module Adyen
  class Management
    attr_accessor :service, :version

    DEFAULT_VERSION = 1
    def initialize(client, version = DEFAULT_VERSION)
      @service = 'Management'
      @client = client
      @version = version
    end

    def api_credentials_company_level_api
      @api_credentials_company_level_api ||= Adyen::APICredentialsCompanyLevelApi.new(@client, @version)
    end

    def api_credentials_merchant_level_api
      @api_credentials_merchant_level_api ||= Adyen::APICredentialsMerchantLevelApi.new(@client, @version)
    end

    def api_key_company_level_api
      @api_key_company_level_api ||= Adyen::APIKeyCompanyLevelApi.new(@client, @version)
    end

    def api_key_merchant_level_api
      @api_key_merchant_level_api ||= Adyen::APIKeyMerchantLevelApi.new(@client, @version)
    end

    def account_company_level_api
      @account_company_level_api ||= Adyen::AccountCompanyLevelApi.new(@client, @version)
    end

    def account_merchant_level_api
      @account_merchant_level_api ||= Adyen::AccountMerchantLevelApi.new(@client, @version)
    end

    def account_store_level_api
      @account_store_level_api ||= Adyen::AccountStoreLevelApi.new(@client, @version)
    end

    def allowed_origins_company_level_api
      @allowed_origins_company_level_api ||= Adyen::AllowedOriginsCompanyLevelApi.new(@client, @version)
    end

    def allowed_origins_merchant_level_api
      @allowed_origins_merchant_level_api ||= Adyen::AllowedOriginsMerchantLevelApi.new(@client, @version)
    end

    def client_key_company_level_api
      @client_key_company_level_api ||= Adyen::ClientKeyCompanyLevelApi.new(@client, @version)
    end

    def client_key_merchant_level_api
      @client_key_merchant_level_api ||= Adyen::ClientKeyMerchantLevelApi.new(@client, @version)
    end

    def my_api_credential_api
      @my_api_credential_api ||= Adyen::MyAPICredentialApi.new(@client, @version)
    end

    def payment_methods_merchant_level_api
      @payment_methods_merchant_level_api ||= Adyen::PaymentMethodsMerchantLevelApi.new(@client, @version)
    end

    def payout_settings_merchant_level_api
      @payout_settings_merchant_level_api ||= Adyen::PayoutSettingsMerchantLevelApi.new(@client, @version)
    end

    def split_configuration_merchant_level_api
      @split_configuration_merchant_level_api ||= Adyen::SplitConfigurationMerchantLevelApi.new(@client, @version)
    end

    def terminal_actions_company_level_api
      @terminal_actions_company_level_api ||= Adyen::TerminalActionsCompanyLevelApi.new(@client, @version)
    end

    def terminal_actions_terminal_level_api
      @terminal_actions_terminal_level_api ||= Adyen::TerminalActionsTerminalLevelApi.new(@client, @version)
    end

    def terminal_orders_company_level_api
      @terminal_orders_company_level_api ||= Adyen::TerminalOrdersCompanyLevelApi.new(@client, @version)
    end

    def terminal_orders_merchant_level_api
      @terminal_orders_merchant_level_api ||= Adyen::TerminalOrdersMerchantLevelApi.new(@client, @version)
    end

    def terminal_settings_company_level_api
      @terminal_settings_company_level_api ||= Adyen::TerminalSettingsCompanyLevelApi.new(@client, @version)
    end

    def terminal_settings_merchant_level_api
      @terminal_settings_merchant_level_api ||= Adyen::TerminalSettingsMerchantLevelApi.new(@client, @version)
    end

    def terminal_settings_store_level_api
      @terminal_settings_store_level_api ||= Adyen::TerminalSettingsStoreLevelApi.new(@client, @version)
    end

    def terminal_settings_terminal_level_api
      @terminal_settings_terminal_level_api ||= Adyen::TerminalSettingsTerminalLevelApi.new(@client, @version)
    end

    def terminals_terminal_level_api
      @terminals_terminal_level_api ||= Adyen::TerminalsTerminalLevelApi.new(@client, @version)
    end

    def users_company_level_api
      @users_company_level_api ||= Adyen::UsersCompanyLevelApi.new(@client, @version)
    end

    def users_merchant_level_api
      @users_merchant_level_api ||= Adyen::UsersMerchantLevelApi.new(@client, @version)
    end

    def webhooks_company_level_api
      @webhooks_company_level_api ||= Adyen::WebhooksCompanyLevelApi.new(@client, @version)
    end

    def webhooks_merchant_level_api
      @webhooks_merchant_level_api ||= Adyen::WebhooksMerchantLevelApi.new(@client, @version)
    end

  end
end
