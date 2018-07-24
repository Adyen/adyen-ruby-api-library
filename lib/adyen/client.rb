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

    def initialize(ws_user = nil, ws_password = nil, api_key = nil, env = :live, adapter = nil, mock_port = 3001)
      @ws_user = ws_user
      @ws_password = ws_password
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
    def service_url(service, action, version)
      "#{service_url_base(service)}/#{service}/v#{version}/#{action}"
    end

    # send request to adyen API
    def call_adyen_api(service, action, request_data, version)
      # get URL for requested endpoint
      url = service_url(service, action, version)

      # make sure right authentication has been provided
      # will use api_key if present, otherwise ws_user and ws_password
      if @api_key.nil?
        if service == "PaymentSetupAndVerification"
          raise Adyen::AuthenticationError.new("Checkout service requires API-key", request_data), "Checkout service requires API-key"
        elsif @ws_password.nil? || @ws_user.nil?
          raise Adyen::AuthenticationError.new("No authentication found - please set api_key or ws_user and ws_password", request_data), "No authentication found - please set api_key or ws_user and ws_password"
        else
          auth_type = "basic"
        end
      else
        auth_type = "api-key"
      end

      # initialize Faraday connection object
      conn = Faraday.new(url: url) do |faraday|
        faraday.adapter @adapter
        faraday.headers["Content-Type"] = "application/json"

        # set auth type based on service
        case auth_type
        when "basic"
          faraday.basic_auth(@ws_user, @ws_password)
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
