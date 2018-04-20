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
        @fund ||= Adyen::Marketpay::Notification.new(@client)
      end
    end

    class Account
      attr_accessor :version

      def initialize(client, version = 3)
        @client = client
        @version = version
        @service = "Account"
      end

      def create_account_holder(request)
        action = 'createAccountHolder'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def update_account_holder(request)
        action = 'updateAccountHolder'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def create_account(request)
        action = 'createAccount'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def update_account(request)
        action = 'updateAccount'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def upload_document(request)
        action = 'uploadDocument'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def get_uploaded_documents(request)
        action = 'getUploadedDocuments'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def get_account_holder(request)
        action = 'getAccountHolder'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def update_account_holder_state(request)
        action = 'updateAccountHolderState'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def delete_bank_accounts(request)
        action = 'deleteBankAccounts'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def delete_shareholders(request)
        action = 'deleteShareholders'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def close_account(request)
        action = 'closeAccount'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def close_account_holder(request)
        action = 'closeAccountHolder'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def get_tier_configuration(request)
        action = 'getTierConfiguration'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def suspend_account_holder(request)
        action = 'suspendAccountHolder'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def un_suspend_account_holder(request)
        action = 'unSuspendAccountHolder'
        @client.call_adyen_api(@service, action, request, @version)
      end
    end

    class Fund
      attr_accessor :version

      def initialize(client, version = 3)
        @client = client
        @version = version
        @service = "Fund"
      end

      def payout_account_holder(request)
        action = 'payoutAccountHolder'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def account_holder_balance(request)
        action = 'accountHolderBalance'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def account_holder_transaction_list(request)
        action = 'accountHolderTransactionList'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def refund_not_paid_out_transfers(request)
        action = 'refundNotPaidOutTransfers'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def setup_beneficiary(request)
        action = 'setupBeneficiary'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def transfer_funds(request)
        action = 'transferFunds'
        @client.call_adyen_api(@service, action, request, @version)
      end
    end

    class Notification
      attr_accessor :version

      def initialize(client, version = 1)
        @client = client
        @version = version
        @service = "Notification"
      end

      def create_notification_configuration(request)
        action = 'createNotificationConfiguration'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def update_notification_configuration(request)
        action = 'updateNotificationConfiguration'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def get_notification_configuration(request)
        action = 'getNotificationConfiguration'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def delete_notification_configurations(request)
        action = 'deleteNotificationConfigurations'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def get_notification_configuration_list(request)
        action = 'getNotificationConfigurationList'
        @client.call_adyen_api(@service, action, request, @version)
      end

      def test_notification_configuration(request)
        action = 'testNotificationConfiguration'
        @client.call_adyen_api(@service, action, request, @version)
      end
    end
  end
end
