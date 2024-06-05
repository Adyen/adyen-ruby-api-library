module Adyen
  module Utils
    class HmacValidator
      HMAC_ALGORITHM = 'sha256'.freeze
      DATA_SEPARATOR = ':'.freeze
      WEBHOOK_VALIDATION_KEYS = %w[
        pspReference originalReference merchantAccountCode merchantReference
        amount.value amount.currency eventCode success
      ].freeze

      # <b>DEPRECATED:</b> Please use valid_webhook_hmac?() instead.
      def valid_notification_hmac?(notification_request_item, hmac_key)
        valid_webhook_hmac?(notification_request_item, hmac_key)
      end

      # validates the HMAC signature of the NotificationRequestItem object. Use for webhooks that provide the
      # hmacSignature as part of the payload `AdditionalData` (i.e. Payments)
      #
      # @param webhook_request_item [Object] The webhook request item.
      # @param hmac_key [String] The HMAC key used to validate the payload.
      
      # @return [Boolean] Returns true if the HMAC signature is valid, otherwise false.      
      def valid_webhook_hmac?(webhook_request_item, hmac_key)
        expected_sign = calculate_webhook_hmac(webhook_request_item, hmac_key)
        merchant_sign =
          webhook_request_item.dig('additionalData', 'hmacSignature')

        expected_sign == merchant_sign
      end

      # validates the HMAC signature of a payload against an expected signature. Use for webhooks that provide the
      # hmacSignature in the HTTP header (i.e. Banking, Management API)
      #
      # @param hmac_signature [String] The HMAC signature to validate.
      # @param hmac_key [String] The HMAC key used to validate the payload.
      # @param payload [String] The webhook payload.

      # @return [Boolean] Returns true if the HMAC signature is valid, otherwise false.      
      def valid_webhook_payload_hmac?(hmac_signature, hmac_key, payload)
        expected_sign = calculate_webhook_payload_hmac(payload, hmac_key)
        puts(expected_sign)
        expected_sign == hmac_signature
      end

      # <b>DEPRECATED:</b> Please use calculate_webhook_hmac() instead.
      def calculate_notification_hmac(notification_request_item, hmac_key)
        calculate_webhook_hmac(notification_request_item, hmac_key)
      end

    
      def calculate_webhook_payload_hmac(data, hmac_key)
        Base64.strict_encode64(
          OpenSSL::HMAC.digest(HMAC_ALGORITHM, [hmac_key].pack('H*'), data)
        )
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
