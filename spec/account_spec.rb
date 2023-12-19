require 'spec_helper'

RSpec.describe Adyen::Payment, service: 'marketpay account service' do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    %w[create_account_holder accountHolderCode TestAccountHolder781664],
    %w[get_account_holder pspReference 8815263414367329],
    %w[update_account_holder pspReference 9914762676580105],
    %w[update_account_holder_state pspReference 8515090175978108],
    %w[suspend_account_holder pspReference 9914762643560032],
    %w[un_suspend_account_holder pspReference 9914762644860159],
    %w[close_account_holder pspReference 9914713476670992],
    %w[create_account status Active],
    %w[update_account pspReference 9914860311410009],
    %w[close_account status Closed],
    %w[upload_document pspReference 9914762681460244],
    %w[get_uploaded_documents pspReference 9914694369860322],
    %w[delete_bank_accounts pspReference 9914694372670551],
    %w[delete_shareholders pspReference 9914694372990637],
    %w[delete_signatories pspReference 9914694372990637],
    %w[delete_payout_methods pspReference 9914694372990637],
    %w[check_account_holder pspReference 9914694372990637]
  ]

  generate_tests(client, 'Account', test_sets, client.marketpay.account)
end
