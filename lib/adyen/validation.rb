module Adyen
  module Validation
    REQUIRED_FIELDS = {
      PaymentSetupAndVerification: {
        payments: [:amount, :merchantAccount, :paymentMethod, :reference, :returnUrl],
        paymentMethods: [:merchantAccount],
        'payments/details': [:details, :paymentData],
        setup: [:amount, :channel, :countryCode, :merchantAccount, :reference, :returnUrl],
        verify: [:payload]
      },
      Payment: {
        authorise: [:amount, :merchantAccount, :reference],
        authorise3d: [:merchantAccount, :shopperIP, :md, :paResponse],
        capture: [:merchantAccount, :originalReference],
        cancel: [:merchantAccount, :originalReference],
        refund: [:merchantAccount, :originalReference, :modificationAmount],
        cancelOrRefund: [:merchantAccount, :originalReference],
        adjustAuthorisation: [:merchantAccount, :originalReference, :modificationAmount]
      },
      Payout: {
        confirmThirdParty: [:merchantAccount, :originalReference],
        declineThirdParty: [:merchantAccount, :originalReference],
        storeDetail: [:merchantAccount, :recurring],
        submitThirdParty: [:amount, :merchantAccount, :recurring, :reference, :shopperEmail, :shopperReference, :selectedRecurringDetailReference],
        storeDetailAndSubmitThirdParty: [:amount, :merchantAccount, :recurring, :reference, :shopperEmail, :shopperReference]
      },
      Recurring: {
        listRecurringDetails: [:merchantAccount, :shopperReference],
        disable: [:merchantAccount, :shopperReference],
        storeToken: [:merchantAccount, :shopperReference, :recurring]
      },
      Account: {
        createAccountHolder: [:accountHolderCode, :accountHolderDetails, :description, :legalEntity],
        getAccountHolder: [:accountHolderCode],
        updateAccountHolder: [:accountHolderCode],
        updateAccountHolderState: [:accountHolderCode, :disable, :stateType],
        suspendAccountHolder: [:accountHolderCode],
        unSuspendAccountHolder: [:accountHolderCode],
        closeAccountHolder: [:accountHolderCode],
        createAccount: [:accountHolderCode],
        updateAccount: [:accountCode],
        closeAccount: [:accountCode],
        uploadDocument: [:documentContent, :documentDetail],
        getUploadedDocuments: [:accountHolderCode],
        deleteBankAccounts: [:accountHolderCode, :bankAccountUUIDs],
        deleteShareholders: [:accountHolderCode, :shareholderCodes]
      },
      Fund: {
        accountHolderBalance: [:accountHolderCode],
        accountHolderTransactionList: [:accountHolderCode],
        payoutAccountHolder: [:accountHolderCode, :accountCode, :amount],
        transferFunds: [:amount, :destinationAccountCode, :sourceAccountCode, :transferCode],
        setupBeneficiary: [:destinationAccountCode, :sourceAccountCode, :merchantReference],
        refundNotPaidOutTransfers: [:accountHolderCode, :accountCode]
      },
      Notification: {
        createNotificationConfiguration: [:configurationDetails],
        getNotificationConfiguration: [:notificationId],
        getNotificationConfigurationList: [],
        testNotificationConfiguration: [:notificationId],
        updateNotificationConfiguration: [:configurationDetails],
        deleteNotificationConfigurations: [:notificationIds]
      }
    }.freeze
  end
end
