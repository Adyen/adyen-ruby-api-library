require_relative 'service'

module Adyen
  module Marketpay
    class Marketpay
      attr_accessor :service

      def initialize(client)
        @client = client
        @service = ""
      end

      def account
        @account ||= Adyen::Marketpay::Account.new(@client)
      end

      def fund
        @fund ||= Adyen::Marketpay::Fund.new(@client)
      end

      def notification
        @notification ||= Adyen::Marketpay::Notification.new(@client)
      end
    end

    class Account < Service
      attr_accessor :version
      DEFAULT_VERSION = 4

      def initialize(client, version = DEFAULT_VERSION)
        service = 'Account'
        method_names = [
          :create_account_holder,
          :update_account_holder,
          :create_account,
          :update_account,
          :upload_document,
          :get_uploaded_documents,
          :get_account_holder,
          :update_account_holder_state,
          :delete_bank_accounts,
          :delete_shareholders,
          :close_account,
          :close_account_holder,
          :get_tier_configuration,
          :suspend_account_holder,
          :un_suspend_account_holder
        ]

        super(client, version, service, method_names)
      end
    end

    class Fund < Service
      attr_accessor :version
      DEFAULT_VERSION = 3

      def initialize(client, version = DEFAULT_VERSION)
        service = 'Fund'
        method_names = [
          :payout_account_holder,
          :account_holder_balance,
          :account_holder_transaction_list,
          :refund_not_paid_out_transfers,
          :setup_beneficiary,
          :transfer_funds
        ]

        super(client, version, service, method_names)
      end
    end

    class Notification < Service
      attr_accessor :version
      DEFAULT_VERSION = 1

      def initialize(client, version = DEFAULT_VERSION)
        service = 'Notification'
        method_names = [
          :create_notification_configuration,
          :update_notification_configuration,
          :get_notification_configuration,
          :delete_notification_configurations,
          :get_notification_configuration_list,
          :test_notification_configuration
        ]

        super(client, version, service, method_names)
      end
    end
  end
end
