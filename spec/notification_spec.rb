require 'spec_helper'

RSpec.describe Adyen::Payment, service: 'marketpay fund service' do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    %w[create_notification_configuration pspReference 8515077331535427],
    %w[delete_notification_configurations pspReference 8515078085249090],
    %w[get_notification_configuration pspReference 8815078078131377],
    %w[get_notification_configuration_list pspReference 8515078078661665],
    %w[test_notification_configuration pspReference 8515078087759211],
    %w[update_notification_configuration pspReference 8515078084389038]
  ]

  generate_tests(client, 'Notification', test_sets, client.marketpay.notification)
end
