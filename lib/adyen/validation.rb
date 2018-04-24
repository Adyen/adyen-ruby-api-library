module Adyen
  module Validation
    REQUIRED_FIELDS = {
      PaymentSetupAndVerification: {
        payments: [:amount, :merchantAccount, :paymentMethod, :reference, :returnUrl],
        paymentMethods: [:merchantAccount],
        :"payments/details" => [:details, :paymentData],
        setup: [:amount, :channel, :countryCode, :merchantAccount, :reference, :returnUrl],
        verify: [:payload]
      }
    }.freeze
  end
end
