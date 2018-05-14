require "spec_helper"

RSpec.describe Adyen::Payments, service: "payouts service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["store_detail", "resultCode", "Success"],
    ["store_detail_and_submit_third_party", "resultCode", "[payout-submit-received]"],
    ["submit_third_party", "resultCode", "[payout-submit-received]"],
    ["confirm_third_party", "response", "[payout-confirm-received]"],
    ["decline_third_party", "response", "[payout-decline-received]"]
  ]

  generate_tests(client, "Payout", test_sets, client.payouts)
end
