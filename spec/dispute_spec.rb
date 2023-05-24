require 'spec_helper'

RSpec.describe Adyen::Dispute, service: 'dispute service' do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ['retrieve_applicable_defense_reasons', 'disputeServiceResult', { 'success' => true }],
    ['supply_defense_document', 'disputeServiceResult', { 'success' => true }],
    ['delete_dispute_defense_document', 'disputeServiceResult', { 'success' => true }],
    ['defend_dispute', 'disputeServiceResult', { 'success' => true }]
  ]

  generate_tests(client, 'DisputeService', test_sets, client.dispute)
end
