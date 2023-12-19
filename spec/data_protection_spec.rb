require 'spec_helper'

RSpec.describe Adyen::DataProtection, service: 'Data Protection Service' do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    %w[request_subject_erasure result SUCCESS]
  ]

  generate_tests(client, 'DataProtectionService', test_sets, client.data_protection)
end
