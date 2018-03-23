require "faraday"

module Adyen
  class Client
    attr_accessor :ws_user, :ws_password, :api_key, :client, :adapter
    attr_reader :env

    def initialize(user = nil, password = nil, api_key = nil, env = :live, adapter = nil)
      @user = user
      @password = password
      @api_key = api_key
      @env = env
      @adapter = adapter || Faraday.default_adapter
    end

    # make sure that env can only be live or test
    def env=(value)
      raise ArgumentError, "Invalid value for Client.env: '#{value}'' - must be one of [:live, :test]" unless [:live, :test].include? value
      @env = value
    end

    # construct full URL from service and endpoint
    def service_url_base(service, action)
      if service == "PaymentSetupAndVerification"
        "https://checkout-#{@env}.adyen.com/services/#{service}/#{action}"
      else
        "https://pal-#{@env}.adyen.com/pal/servlet/#{service}/#{action}"
      end
    end

    # send request to adyen API
    def call_adyen_api(service, action, request_data)
      url = service_url_base(service, action)

      # make sure right authentication has been provided
      case service
      when "PaymentSetupAndVerification"
        raise ArgumentError, "Checkout API-key not set" if @api_key.nil?
        auth_type = "x-api-key"
      when "Payment", "Recurring", "Payout"
        raise ArgumentError, "Client.user and client.password must be set" if @password.nil? || @user.nil?
        auth_type = "basic"
      end

      # initialize Faraday connection object
      conn = Faraday.new(url: url) do |faraday|
        faraday.adapter @adapter
        faraday.headers["Content-Type"] = "application/json"

        # set auth type based on service
        case auth_type
        when "basic"
          faraday.basic_auth(@user, @password)
        when "x-api-key"
          faraday.headers["x-api-key"] = @api_key
        end
      end

      # post request to Adyen
      begin
        conn.post do |req|
          req.body = request_data
        end

      # handle API errors
      rescue Faraday::ConnectionFailed => connection_error
        puts connection_error
        puts "Please confirm that Client.env is set to the right value (:live or :test)"
      end
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
  end
end
