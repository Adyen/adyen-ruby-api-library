require 'spec_helper'
require_relative '../lib/adyen/errors'

RSpec.describe Adyen::Payment, service: 'recurring service' do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ['list_recurring_details', 'creationDate', '2017-03-01T11:53:11+01:00'],
    ['disable', 'response', '[detail-successfully-disabled]'],
    ['create_permit', 'pspReference', '8815260599791117'],
    ['schedule_account_updater', 'result', 'Success']
  ]

  generate_tests(client, 'Recurring', test_sets, client.recurring)
end
