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
        merchant_sign =
          webhook_request_item.dig('additionalData', 'hmacSignature')

        expected_sign == merchant_sign
      end

      def calculate_webhook_hmac(webhook_request_item, hmac_key)
        data = data_to_sign(webhook_request_item)

        Base64.strict_encode64(
          OpenSSL::HMAC.digest(HMAC_ALGORITHM, [hmac_key].pack('H*'), data)
        )
      end

      # TODO: Deprecate instead of aliasing
      alias valid_notification_hmac? valid_webhook_hmac?
      alias calculate_notification_hmac calculate_webhook_hmac

      def data_to_sign(webhook_request_item)
        WEBHOOK_VALIDATION_KEYS
          .map { webhook_request_item.dig(*_1.split('.')).to_s }
          .compact
          .join(DATA_SEPARATOR)
      end
    end
  end
end
