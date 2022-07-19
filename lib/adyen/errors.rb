module Adyen
  class AdyenError < StandardError
    attr_reader :code, :response, :request, :msg

    def initialize(request = nil, response = nil, msg = nil, code = nil)
      unless request.nil?
        request = request.is_a?(Hash) ? request : JSON.parse(request, symbolize_names: true)
        mask_fields(request)
      end

      # components of formatted error message
      attributes = {
        code: code,
        msg: msg,
        request: request,
        response: response
      }.select { |_k, v| v }.map { |k, v| "#{k}:#{v}" }.join(', ')
      message = "#{self.class.name} #{attributes}"
      super(message)

      # internal variables
      @code = code
      @response = response
      @request = request
      @msg = msg
    end

    # mask PCI data in request
    def mask_fields(request)
      return if request.nil?

      # sensitive fields
      fields_to_mask = [
        :expiryMonth,
        :expiryYear,
        :encryptedCardNumber,
        :encryptedExpiryMonth,
        :encryptedExpiryYear,
        :encryptedSecurityCode
      ]

      # convert to hash if necessary
      request = request.is_a?(Hash) ? request : JSON.parse(request, symbolize_names: true)

      # iterate through request to find fields to mask
      request.each do |k, v|
        if request[k].is_a?(Hash)
          # recursively traverse multi-level hashes
          mask_fields(request[k])
        else
          if k == :number
            # show first 6 and last 4 for cards
            request[k] = "#{v[0,6]}******#{v[12,16]}"
          elsif k == :cvc
            # show length of cvc for debugging
            request[k] = "*" * v.length
          elsif fields_to_mask.include? k
            # generic mask for other fields
            request[k] = "***"
          end
        end
      end
    end
  end

  class AuthenticationError < AdyenError
    def initialize(msg, request)
      super(request, nil, msg, 401)
    end
  end

  class PermissionError < AdyenError
    def initialize(msg, request)
      super(request, nil, msg, 403)
    end
  end

  class FormatError < AdyenError
    def initialize(msg, request, response)
      super(request, response, msg, 422)
    end
  end

  class ServerError < AdyenError
    def initialize(msg, request, response)
      super(request, response, msg, 500)
    end
  end

  class ConfigurationError < AdyenError
    def initialize(msg, request)
      super(request, nil, msg, 905)
    end
  end

  class ValidationError < AdyenError
    def initialize(msg, request)
      super(request, nil, msg, nil)
    end
  end

  # catchall for errors which don't have more specific classes
  class APIError < AdyenError
    def initialize(msg, request, response, code)
      super(request, response, msg, code)
    end
  end
end
