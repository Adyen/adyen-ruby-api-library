# rubocop:disable Layout/LineLength

require 'spec_helper'

RSpec.describe Adyen::Service do
  describe '.action_for_method_name' do
    it 'handles all methods that exist currently' do
      expect(described_class.action_for_method_name(:adjust_authorisation)).to eq 'adjustAuthorisation'
      expect(described_class.action_for_method_name(:authorise)).to eq 'authorise'
      expect(described_class.action_for_method_name(:authorise3d)).to eq 'authorise3d'
      expect(described_class.action_for_method_name(:authorise3ds2)).to eq 'authorise3ds2'
      expect(described_class.action_for_method_name(:cancel)).to eq 'cancel'
      expect(described_class.action_for_method_name(:cancel_or_refund)).to eq 'cancelOrRefund'
      expect(described_class.action_for_method_name(:capture)).to eq 'capture'
      expect(described_class.action_for_method_name(:close_account)).to eq 'closeAccount'
      expect(described_class.action_for_method_name(:close_account_holder)).to eq 'closeAccountHolder'
      expect(described_class.action_for_method_name(:confirm_third_party)).to eq 'confirmThirdParty'
      expect(described_class.action_for_method_name(:create_account)).to eq 'createAccount'
      expect(described_class.action_for_method_name(:create_account_holder)).to eq 'createAccountHolder'
      expect(described_class.action_for_method_name(:decline_third_party)).to eq 'declineThirdParty'
      expect(described_class.action_for_method_name(:delete_bank_accounts)).to eq 'deleteBankAccounts'
      expect(described_class.action_for_method_name(:delete_shareholders)).to eq 'deleteShareholders'
      expect(described_class.action_for_method_name(:delete_signatories)).to eq 'deleteSignatories'
      expect(described_class.action_for_method_name(:disable)).to eq 'disable'
      expect(described_class.action_for_method_name(:donate)).to eq 'donate'
      expect(described_class.action_for_method_name(:get_account_holder)).to eq 'getAccountHolder'
      expect(described_class.action_for_method_name(:get_tier_configuration)).to eq 'getTierConfiguration'
      expect(described_class.action_for_method_name(:get_uploaded_documents)).to eq 'getUploadedDocuments'
      expect(described_class.action_for_method_name(:list_recurring_details)).to eq 'listRecurringDetails'
      expect(described_class.action_for_method_name(:origin_keys)).to eq 'originKeys'
      expect(described_class.action_for_method_name(:payment_methods)).to eq 'paymentMethods'
      expect(described_class.action_for_method_name(:payment_session)).to eq 'paymentSession'
      expect(described_class.action_for_method_name(:payment_links)).to eq 'paymentLinks'
      expect(described_class.action_for_method_name(:refund)).to eq 'refund'
      expect(described_class.action_for_method_name(:store_detail)).to eq 'storeDetail'
      expect(described_class.action_for_method_name(:store_detail_and_submit_third_party)).to eq 'storeDetailAndSubmitThirdParty'
      expect(described_class.action_for_method_name(:store_token)).to eq 'storeToken'
      expect(described_class.action_for_method_name(:submit_third_party)).to eq 'submitThirdParty'
      expect(described_class.action_for_method_name(:suspend_account_holder)).to eq 'suspendAccountHolder'
      expect(described_class.action_for_method_name(:un_suspend_account_holder)).to eq 'unSuspendAccountHolder'
      expect(described_class.action_for_method_name(:update_account)).to eq 'updateAccount'
      expect(described_class.action_for_method_name(:update_account_holder)).to eq 'updateAccountHolder'
      expect(described_class.action_for_method_name(:update_account_holder_state)).to eq 'updateAccountHolderState'
      expect(described_class.action_for_method_name(:upload_document)).to eq 'uploadDocument'
      expect(described_class.action_for_method_name(:get_onboarding_url)).to eq 'getOnboardingUrl'
    end
  end
end
# rubocop:enable Layout/LineLength
# rubocop:enable Metrics/BlockLength
