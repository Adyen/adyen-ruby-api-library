require "spec_helper"

RSpec.describe Adyen::PosTerminalManagement, service: "POS Terminal Management service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["find_terminal", "merchantAccount", "TestMerchant"],
    ["get_terminals_under_account", "merchantAccounts", [{ "merchantAccount" => "TestMerchant", "inStoreTerminals" => ["P400Plus-123456789"] }]],
    ["assign_terminals", "results", { "e285-123456789" => "Done" }]
  ]

  generate_tests(client, "Terminal", test_sets, client.postfmapi)
end
