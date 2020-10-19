require "spec_helper"

RSpec.describe Adyen::BinLookup, service: "BIN lookup service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["get_3ds_availability", "threeDS2supported", false],
    ["get_cost_estimate", "resultCode", "Success"]
  ]

  generate_tests(client, "BinLookup", test_sets, client.bin_lookup)
end
