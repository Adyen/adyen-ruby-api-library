module Adyen
  class AdyenError < StandardError
    attr_reader :code, :response, :request, :msg

    def initialize(request = nil, response = nil, msg = nil, code = nil)
      # mask PCI data in request
      if not request.nil?
        request = request.is_a?(Hash) ? request : JSON.parse(request)
        request.each do |k, v|
          if request[k].is_a?(Hash)
            request[k].each do |k2, v2|
              if k2 == :number
                request[k][k2] = "#{v2[0,6]}******#{v2[12,16]}"
              elsif k2 == :cvc
                request[k][k2] = "*" * v2.length
              end
            end
          end
        end
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
