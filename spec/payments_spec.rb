require "spec_helper"

RSpec.describe Adyen::Payments, service: "payments service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["authorise", "resultCode", "Authorised"],
    ["adjust_authorisation", "response", "[adjustAuthorisation-received]"],
    ["authorise3d", "resultCode", "Authorised"],
    ["authorise3ds2", "resultCode", "ChallengeShopper"],
    ["cancel", "response", "[cancel-received]"],
    ["cancel_or_refund", "response", "[cancelOrRefund-received]"],
    ["capture", "response", "[capture-received]"],
    ["refund", "response", "[refund-received]"],
    ["donate", "response", "[donation-received]"],
    ["get_authentication_result", "threeDS2Result", {"transStatus" => "Y"}],
    ["retrieve_3ds2_result", "threeDS2Result", {"transStatus" => "Y"}],
    ["technical_cancel", "originalReference", "9914694372990637"],
    ["void_pending_refund", "pspReference", "9914694372990637"]
  ]

  generate_tests(client, "Payment", test_sets, client.payments)
end
