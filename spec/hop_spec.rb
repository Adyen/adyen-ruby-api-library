require 'spec_helper'

RSpec.describe Adyen::Payment, service: 'marketpay hop service' do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    %w[get_onboarding_url pspReference 8815850625171183]
  ]

  generate_tests(client, 'Hop', test_sets, client.marketpay.hop)
end
