module Adyen
  module Utils
    class HmacValidator
      HMAC_ALGORITHM = 'sha256'.freeze
      DATA_SEPARATOR = ':'.freeze
      WEBHOOK_VALIDATION_KEYS = %w[
        pspReference originalReference merchantAccountCode merchantReference
        amount.value amount.currency eventCode success
      ].freeze

      def valid_webhook_hmac?(webhook_request_item, hmac_key)
        expected_sign = calculate_webhook_hmac(webhook_request_item, hmac_key)
        merchant_sign = fetch(webhook_request_item, 'additionalData.hmacSignature')

        expected_sign == merchant_sign
      end

      def calculate_webhook_hmac(webhook_request_item, hmac_key)
        data = data_to_sign(webhook_request_item)

        Base64.strict_encode64(OpenSSL::HMAC.digest(HMAC_ALGORITHM, [hmac_key].pack('H*'), data))
      end


      def data_to_sign(webhook_request_item)
        data = WEBHOOK_VALIDATION_KEYS.map { |key| fetch(webhook_request_item, key).to_s }
                                    .join(DATA_SEPARATOR)
      end

      private

      def fetch(hash, keys)
        value = hash
        keys.to_s.split('.').each do |key|
          value = if key.to_i.to_s == key
                    value[key.to_i]
                  else
                    value[key].nil? ? value[key.to_sym] : value[key]
                  end
          break if value.nil?
        end

        value
      end
    end
  end
end
