require "spec_helper"

RSpec.describe Adyen::Payments, service: "marketpay fund service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["payout_account_holder", "pspReference", "9915090894325643"],
    ["account_holder_balance", "pspReference", "9914719436100053"],
    ["account_holder_transaction_list", "pspReference", "9914721175530029"],
    ["refund_not_paid_out_transfers", "pspReference", "9915090894215323"],
    ["setup_beneficiary", "pspReference", "9914860354282596"],
    ["transfer_funds", "pspReference", "9915090893984580"]
  ]

  generate_tests(client, "Fund", test_sets, client.marketpay.fund)
end
