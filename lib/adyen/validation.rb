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
        authorise3d: [:amount, :merchantAccount, :reference, :md, :paResponse],
        capture: [:merchantAccount, :originalReference],
        cancel: [:merchantAccount, :originalReference],
        refund: [:merchantAccount, :originalReference, :modificationAmount],
        cancel_or_refund: [:merchantAccount, :originalReference],
        adjust_authorisation: [:merchantAccount, :originalReference, :modificationAmount]
      },
      Payout: {
        confirm_third_party: [:merchantAccount, :originalReference],
        decline_third_party: [:merchantAccount, :originalReference],
        store_details: [:merchantAccount, :recurring],
        submit_third_party: [:amount, :merchantAccount, :recurring, :reference, :shopperEmail, :shopperReference, :selectedRecurringDetailReference],
        store_detail_and_stubmit_third_party: [:amount, :merchantAccount, :recurring, :reference, :shopperEmail, :shopperReference]
      }
    }.freeze
  end
end
