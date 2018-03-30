module Adyen
  class AdyenError < StandardError
    attr_reader :code, :response, :request

    def initialize(request = nil, response = nil, msg = nil, code = nil)
      @code = code
      @response = response
      @request = request
      @msg = msg
    end
  end

  class AuthenticationError < AdyenError
    def initialize(msg, request)
      @code = 401
      @response = nil
      @request = request
      @msg = msg
    end
  end

  class PermissionError < AdyenError
    def initialize(msg, request)
      @code = 403
      @response = nil
      @request = request
      @msg = msg
    end
  end

  class FormatError < AdyenError
    def initialize(msg, request, response)
      @code = 422
      @response = response
      @request = request
      @msg = msg
    end
  end

  class ServerError < AdyenError
    def initialize(msg, request, response)
      @code = 500
      @response = response
      @request = request
      @msg = msg
    end
  end

  class ConfigurationError < AdyenError
    def initialize(msg, request)
      @code = 905
      @response = nil
      @request = request
      @msg = msg
    end
  end

  class ValidationError < AdyenError
    def initialize(msg, request)
      @code = nil
      @response = nil
      @request = request
      @msg = msg
    end
  end

  # catchall for errors which don't have more specific classes
  class APIError < AdyenError
    def initialize(msg, request, response, code)
      @code = code
      @response = response
      @request = request
      @msg = msg
    end
  end
end
