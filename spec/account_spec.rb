require "spec_helper"

RSpec.describe Adyen::Payments, service: "marketpay account service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["create_account_holder", "accountHolderCode", "TestAccountHolder781664"],
    ["get_account_holder", "pspReference", "8815263414367329"],
    ["update_account_holder", "pspReference", "9914762676580105"],
    ["update_account_holder_state", "pspReference", "8515090175978108"],
    ["suspend_account_holder", "pspReference", "9914762643560032"],
    ["un_suspend_account_holder", "pspReference", "9914762644860159"],
    ["close_account_holder", "pspReference", "9914713476670992"],
    ["create_account", "status", "Active"],
    ["update_account", "pspReference", "9914860311410009"],
    ["close_account", "status", "Closed"],
    ["upload_document", "pspReference", "9914762681460244"],
    ["get_uploaded_documents", "pspReference", "9914694369860322"],
    ["delete_bank_accounts", "pspReference", "9914694372670551"],
    ["delete_shareholders", "pspReference", "9914694372990637"]
  ]

  generate_tests(client, "Account", test_sets, client.marketpay.account)
end
