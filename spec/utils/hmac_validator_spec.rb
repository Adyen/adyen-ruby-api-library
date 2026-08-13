require 'spec_helper'
require 'open3'

RSpec.describe Adyen::Utils::HmacValidator do
  let(:validator) { described_class.new }
  let(:key) { '44782DEF547AAA06C910C43932B1EB0C71FC68D9D0C057550C48EC2ACF6BA056' }
  let(:expected_sign) { 'coqCmt/IZ4E3CzPvMY8zTjQVL5hYJUiBRg8UU+iCWo0=' }
  let(:webhook_request_item) do
    {
      'additionalData' => {
        'hmacSignature' => expected_sign
      },
      'amount' => {
        'value' => 1130,
        'currency' => 'EUR'
      },
      'pspReference' => '7914073381342284',
      'eventCode' => 'AUTHORISATION',
      'merchantAccountCode' => 'TestMerchant',
      'merchantReference' => 'TestPayment-1407325143704',
      'paymentMethod' => 'visa',
      'success' => 'true'
    }
  end

  describe 'HMAC Validator' do
    it 'should get correct data' do
      data_to_sign = validator.data_to_sign(webhook_request_item)
      expect(data_to_sign).to eq '7914073381342284::TestMerchant:TestPayment-1407325143704:1130:EUR:AUTHORISATION:true'
    end

    it 'should encrypt properly' do
      encrypted = validator.calculate_webhook_hmac(webhook_request_item, key)
      expect(encrypted).to eq expected_sign
    end

    it 'should have a valid hmac' do
      expect(validator.valid_webhook_hmac?(webhook_request_item, key)).to be true
    end

    it 'should have an invalid hmac' do
      webhook_request_item['additionalData'] = { 'hmacSignature' => 'invalidHMACsign' }

      expect(validator.valid_webhook_hmac?(webhook_request_item, key)).to be false
    end

    it 'should validate backslashes correctly' do
      webhook = JSON.parse(json_from_file('mocks/responses/Webhooks/backslash_webhook.json'))
      expect(validator.valid_webhook_hmac?(webhook, '74F490DD33F7327BAECC88B2947C011FC02D014A473AAA33A8EC93E4DC069174')).to be true
    end

    it 'should validate colons correctly' do
      webhook = JSON.parse(json_from_file('mocks/responses/Webhooks/colon_webhook.json'))
      expect(validator.valid_webhook_hmac?(webhook, '74F490DD33F7327BAECC88B2947C011FC02D014A473AAA33A8EC93E4DC069174')).to be true
    end

    it 'should validate forward slashes correctly' do
      webhook = JSON.parse(json_from_file('mocks/responses/Webhooks/forwardslash_webhook.json'))
      expect(validator.valid_webhook_hmac?(webhook, '74F490DD33F7327BAECC88B2947C011FC02D014A473AAA33A8EC93E4DC069174')).to be true
    end

    it 'should validate mix of slashes and colon correctly' do
      webhook = JSON.parse(json_from_file('mocks/responses/Webhooks/mixed_webhook.json'))
      expect(validator.valid_webhook_hmac?(webhook, '74F490DD33F7327BAECC88B2947C011FC02D014A473AAA33A8EC93E4DC069174')).to be true
    end

    it 'should have an invalid payload hmac' do
      hmac_signature = "wrong signature"
      payload = json_from_file('mocks/responses/Webhooks/mixed_webhook.json')

      expect(validator.valid_webhook_payload_hmac?(hmac_signature, key, payload)).to be false
    end

    it 'should have an valid payload hmac' do
      hmac_signature = "93Av9t6OVkYCrVHU/xgiTkWGbulJz+Vcm2qO4TYQH2Q="
      payload = json_from_file('mocks/responses/Webhooks/mixed_webhook.json')

      expect(validator.valid_webhook_payload_hmac?(hmac_signature, key, payload)).to be true
    end

  end

  describe 'consumer-side regression' do
    # Run the validator in a clean Ruby process that only loads the library, like
    # a consumer application, so test dependencies cannot mask missing dependencies.
    it 'computes HMAC signatures in a clean consumer process' do
      lib_dir = File.expand_path('../../lib', __dir__)
      smoke_test = File.expand_path('consumer_smoke.rb', __dir__)

      stdout, stderr, status = Open3.capture3(Gem.ruby, '-I', lib_dir, smoke_test)

      expect(status).to be_success,
                        "library must work in a clean consumer process.\nstdout: #{stdout}\nstderr: #{stderr}"
    end
  end

  describe 'deprecated methods' do
    around do |example|
      previous = Warning[:deprecated]
      Warning[:deprecated] = true
      example.run
    ensure
      Warning[:deprecated] = previous
    end

    it 'valid_notification_hmac? emits a deprecation warning and still validates' do
      result = nil
      expect do
        result = validator.valid_notification_hmac?(webhook_request_item, key)
      end.to output(/\[DEPRECATED\] `valid_notification_hmac\?` is deprecated\. Use valid_webhook_hmac\?\(\) instead\.\n/).to_stderr

      expect(result).to be true
    end

    it 'calculate_notification_hmac emits a deprecation warning and still calculates' do
      result = nil
      expect do
        result = validator.calculate_notification_hmac(webhook_request_item, key)
      end.to output(/\[DEPRECATED\] `calculate_notification_hmac` is deprecated\. Use calculate_webhook_hmac\(\) instead\.\n/).to_stderr

      expect(result).to eq expected_sign
    end
  end
end
# rubocop:enable Metrics/BlockLength
