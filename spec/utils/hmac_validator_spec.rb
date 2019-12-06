require 'spec_helper'

RSpec.describe Adyen::Utils::HmacValidator do
  let(:validator) { described_class.new }
  let(:key) { '44782DEF547AAA06C910C43932B1EB0C71FC68D9D0C057550C48EC2ACF6BA056' }
  let(:expected_sign) { 'coqCmt/IZ4E3CzPvMY8zTjQVL5hYJUiBRg8UU+iCWo0=' }
  let(:notification_request_item) do
    {
      additionalData: {
        hmacSignature: expected_sign
      },
      amount: {
        value: 1130,
        currency: 'EUR'
      },
      pspReference: '7914073381342284',
      eventCode: 'AUTHORISATION',
      merchantAccountCode: 'TestMerchant',
      merchantReference: 'TestPayment-1407325143704',
      paymentMethod: 'visa',
      success: 'true'
    }
  end

  describe 'HMAC Validator' do
    it 'should get correct data' do
      data_to_sign = validator.data_to_sign(notification_request_item)
      expect(data_to_sign).to eq '7914073381342284::TestMerchant:TestPayment-1407325143704:1130:EUR:AUTHORISATION:true'
    end

    it 'should get correct data with escaped characters' do
      notification_request_item['merchantAccountCode'] = 'Test:\\Merchant'
      data_to_sign = validator.data_to_sign(notification_request_item)
      expect(data_to_sign).to eq '7914073381342284::Test\\:\\Merchant:TestPayment-1407325143704:1130:EUR:AUTHORISATION:true'
    end

    it 'should encrypt properly' do
      encrypted = validator.calculate_notification_hmac(notification_request_item, key)
      expect(encrypted).to eq expected_sign
    end

    it 'should have a valid hmac' do
      expect(validator.valid_notification_hmac?(notification_request_item, key)).to be true
    end

    it 'should have an invalid hmac' do
      notification_request_item['additionalData'] = { 'hmacSignature' => 'invalidHMACsign' }

      expect(validator.valid_notification_hmac?(notification_request_item, key)).to be false
    end
  end
end
