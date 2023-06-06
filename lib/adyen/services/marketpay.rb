# rubocop:disable Metrics/MethodLength

require_relative 'service'

module Adyen
  module Marketpay
    class Marketpay
      attr_accessor :service

      def initialize(client)
        @client = client
        @service = ''
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

      def hop
        @hop ||= Adyen::Marketpay::Hop.new(@client)
      end
    end

    class Account < Service
      attr_accessor :version

      DEFAULT_VERSION = 6

      def initialize(client, version = DEFAULT_VERSION)
        service = 'Account'
        method_names = %i[
          create_account_holder
          update_account_holder
          create_account
          update_account
          upload_document
          get_uploaded_documents
          get_account_holder
          update_account_holder_state
          delete_bank_accounts
          delete_shareholders
          delete_signatories
          close_account
          close_account_holder
          suspend_account_holder
          un_suspend_account_holder
          delete_payout_methods
          check_account_holder
        ]

        super(client, version, service, method_names)
      end
    end

    class Fund < Service
      attr_accessor :version

      DEFAULT_VERSION = 6

      def initialize(client, version = DEFAULT_VERSION)
        method_names = %i[
          payout_account_holder
          account_holder_balance
          account_holder_transaction_list
          refund_not_paid_out_transfers
          setup_beneficiary
          transfer_funds
          refund_funds_transfer
        ]

        super(client, version, 'Fund', method_names)
      end
    end

    class Notification < Service
      attr_accessor :version

      DEFAULT_VERSION = 6

      def initialize(client, version = DEFAULT_VERSION)
        service = 'Notification'
        method_names = %i[
          create_notification_configuration
          update_notification_configuration
          get_notification_configuration
          delete_notification_configurations
          get_notification_configuration_list
          test_notification_configuration
        ]

        super(client, version, service, method_names)
      end
    end

    class Hop < Service
      attr_accessor :version

      DEFAULT_VERSION = 6

      def initialize(client, version = DEFAULT_VERSION)
        service = 'Hop'
        method_names = [
          :get_onboarding_url
        ]

        super(client, version, service, method_names)
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
