require "faraday"
require "json"
require "active_support"
require "active_support/core_ext"
require "rexml/document"

require_relative "./errors"

module Adyen
  class Client
    attr_accessor :ws_user, :ws_password, :api_key, :client, :adapter
    attr_reader :env

    REQUIRED_FIELDS = {
      PaymentSetupAndVerification: {
        payments: [:amount, :merchantAccount, :paymentMethod, :reference, :returnUrl],
        paymentMethods: [:merchantAccount],
        "payments/details".to_sym => [:details, :paymentData],
        setup: [:amount, :channel, :countryCode, :merchantAccount, :reference, :returnUrl],
        verify: [:payload]
      }
    }.freeze

    def initialize(user = nil, password = nil, api_key = nil, env = :live, adapter = nil, mock_port = 3001)
      @user = user
      @password = password
      @api_key = api_key
      @env = env
      @adapter = adapter || Faraday.default_adapter
      @mock_port = mock_port
    end

    # make sure that env can only be live or test
    def env=(value)
      raise ArgumentError, "Invalid value for Client.env: '#{value}'' - must be one of [:live, :test, :mock]" unless [:live, :test, :mock].include? value
      @env = value
    end

    # base URL for API given service and @env
    def service_url_base(service)
      if @env == :mock
        "http://localhost:#{@mock_port}"
      else
        case service
        when "PaymentSetupAndVerification"
          "https://checkout-#{@env}.adyen.com/services"
        when "Account", "Fund", "Notification"
          "https://cal-#{@env}.adyen.com/cal/services"
        when "Recurring", "Payment"
          "https://pal-#{@env}.adyen.com/pal/servlet"
        else
          raise ArgumentError, "Invalid service specified"
        end
      end
    end

    # construct full URL from service and endpoint
    def service_url(service, action)
      "#{service_url_base(service)}/#{service}/#{action}"
    end

    # validate string to be sent to API
    def check_request_validity(service, action, request)
      # create error for use later
      error_message = "Request data must be a json-parsable string"
      error_object = Adyen::ValidationError.new(error_message, request)

      # type checking (not really rubinic)
      raise error_object, error_message if !request.is_a?(String)
      begin
        # attempt to parse request string
        mappable_request = JSON.parse(request)
      rescue JSON::ParserError
        raise error_object, error_message
      end

      # make sure all required fields are present
      missing_fields = []
      REQUIRED_FIELDS[service.to_sym][action.to_sym].map do |required_field|
        key_present = false
        mappable_request.keys.map do |json_key|
          if json_key.to_sym == required_field
            key_present = true
            break
          end
        end
        if !key_present
          missing_fields << required_field
        end
      end

      # raise an error if a field is missing
      raise Adyen::ValidationError.new("Missing required field(s) #{missing_fields} in request", request), "Missing required field(s) #{missing_fields} in request" unless missing_fields.empty?
    end

    # send request to adyen API
    def call_adyen_api(service, action, request_data)
      # get URL for requested endpoint
      url = service_url(service, action)

      # make sure right authentication has been provided
      case service
      when "PaymentSetupAndVerification"
        raise Adyen::PermissionError.new("Checkout API-key not set", request_data), "Checkout API-key not set" if @api_key.nil?
        auth_type = "api-key"
      when "Payment", "Recurring", "Payout"
        raise Adyen::AuthenticationError.new("Client.user and client.password must be set", request_data), "Client.user and client.password must be set" if @password.nil? || @user.nil?
        auth_type = "basic"
      end

      # validate request
      check_request_validity(service, action, request_data)

      # initialize Faraday connection object
      conn = Faraday.new(url: url) do |faraday|
        faraday.adapter @adapter
        faraday.headers["Content-Type"] = "application/json"

        # set auth type based on service
        case auth_type
        when "basic"
          faraday.basic_auth(@user, @password)
        when "api-key"
          faraday.headers["x-api-key"] = @api_key
        end
      end

      # post request to Adyen
      begin
        response = conn.post do |req|
          req.body = request_data
        end

      # handle client errors
      rescue Faraday::ConnectionFailed => connection_error
        raise connection_error, "Please confirm that Client.env is set to the right value (:live or :test)"
      end

      # check for API errors
      case response.status
      when 401
        raise Adyen::AuthenticationError.new("Invalid webservice username / password", request_data)
      when 403
        raise Adyen::PermissionError.new("Invalid Checkout API key", request_data)
      end

      response
    end

    # services
    def checkout
      @checkout ||= Adyen::Checkout.new(self)
    end

    def payments
      @payments ||= Adyen::Payments.new(self)
    end

    def payouts
      @payouts ||= Adyen::Payouts.new(self)
    end

    def recurring
      @recurring ||= Adyen::Recurring.new(self)
    end

    def marketpay
      @marketpay ||= Adyen::Marketpay::Marketpay.new(self)
    end
  end
end
