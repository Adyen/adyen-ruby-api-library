require "spec_helper"

RSpec.describe Adyen::Payments, service: "marketpay fund service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["create_notification_configuration", "pspReference", "8515077331535427"],
    ["delete_notification_configurations", "pspReference", "8515078085249090"],
    ["get_notification_configuration", "pspReference", "8815078078131377"],
    ["get_notification_configuration_list", "pspReference", "8515078078661665"],
    ["test_notification_configuration", "pspReference", "8515078087759211"],
    ["update_notification_configuration", "pspReference", "8515078084389038"]
  ]

  generate_tests(client, "Notification", test_sets, client.marketpay.notification)
end
