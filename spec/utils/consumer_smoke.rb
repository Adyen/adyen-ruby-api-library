# Consumer smoke test for the HMAC validator, run by hmac_validator_spec.rb.
# Executed in a clean Ruby process that only loads the library.
# Exits non-zero (via abort) when the library cannot be used standalone.

require 'adyen-ruby-api-library'

validator = Adyen::Utils::HmacValidator.new
key = '44782DEF547AAA06C910C43932B1EB0C71FC68D9D0C057550C48EC2ACF6BA056'
webhook_request_item = {
  'additionalData' => { 'hmacSignature' => 'coqCmt/IZ4E3CzPvMY8zTjQVL5hYJUiBRg8UU+iCWo0=' },
  'amount' => { 'value' => 1130, 'currency' => 'EUR' },
  'pspReference' => '7914073381342284',
  'eventCode' => 'AUTHORISATION',
  'merchantAccountCode' => 'TestMerchant',
  'merchantReference' => 'TestPayment-1407325143704',
  'paymentMethod' => 'visa',
  'success' => 'true'
}

abort 'valid_webhook_hmac? returned false' unless validator.valid_webhook_hmac?(webhook_request_item, key)

payload_sign = validator.calculate_webhook_payload_hmac('payload', key)
abort "unexpected payload hmac: #{payload_sign}" unless payload_sign == 'McjT0WKyyQ5Zqv3FC9sVNf14NYfSAZa1chxoXY3yIlE='
