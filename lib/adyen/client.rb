require "faraday"
require "json"
require_relative "./errors"

module Adyen
  class Client
    attr_accessor :ws_user, :ws_password, :api_key, :client, :adapter, :live_url_prefix
    attr_reader :env

    def initialize(ws_user: nil, ws_password: nil, api_key: nil, env: :live, adapter: nil, mock_port: 3001, live_url_prefix: nil)
      @ws_user = ws_user
      @ws_password = ws_password
      @api_key = api_key
      @env = env
      @adapter = adapter || Faraday.default_adapter
      @mock_port = mock_port
      @live_url_prefix = live_url_prefix
    end

    # make sure that env can only be :live, :test, or :mock
    def env=(value)
      raise ArgumentError, "Invalid value for Client.env: '#{value}'' - must be one of [:live, :test, :mock]" unless [:live, :test, :mock].include? value
      @env = value
    end

    # remove 'https' from live_url_prefix if necessary
    def live_url_prefix=(value)
      if not value["https://"].nil?
        value["https://"] = ""
      end
      @live_url_prefix = value
    end

    # base URL for API given service and @env
    def service_url_base(service)
      raise ArgumentError, "Please set Client.live_url_prefix to the portion of your merchant-specific URL prior to '-[service]-live.adyenpayments.com'" if @live_url_prefix.nil? and @env == :live
      if @env == :mock
        "http://localhost:#{@mock_port}"
      else
        case service
        when "Checkout"
          url = "https://checkout-#{@env}.adyen.com/checkout"
        when "CheckoutUtility"
          url = "https://checkout-#{@env}.adyen.com"
        when "Account", "Fund", "Notification"
          url = "https://cal-#{@env}.adyen.com/cal/services"
        when "Recurring", "Payment", "Payout"
          url = "https://pal-#{@env}.adyen.com/pal/servlet"
        else
          raise ArgumentError, "Invalid service specified"
        end

        if @env == :live
          url.insert(8, "#{@live_url_prefix}-")
          url["adyen.com"] = "adyenpayments.com"
        end

        return url
      end
    end

    # construct full URL from service and endpoint
    def service_url(service, action, version)
      if service == "Checkout"
        "#{service_url_base(service)}/v#{version}/#{action}"
      else
        "#{service_url_base(service)}/#{service}/v#{version}/#{action}"
      end
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
        faraday.headers["User-Agent"] = Adyen::NAME + "/" + Adyen::VERSION

        # set auth type based on service
        case auth_type
        when "basic"
          faraday.basic_auth(@ws_user, @ws_password)
        when "api-key"
          faraday.headers["x-api-key"] = @api_key
        end
      end

      # if json string convert to hash
      # needed to add applicationInfo
      if request_data.is_a?(String)
        request_data = JSON.parse(request_data)
      end

      # add application only on checkout service
      if service == 'Checkout' || service == 'CheckoutUtility'
        add_application_info(request_data)
      end

      # convert to json
      request_data = request_data.to_json

      # post request to Adyen
      begin
        response = conn.post do |req|
          req.body = request_data
        end # handle client errors
      rescue Faraday::ConnectionFailed => connection_error
        raise connection_error, "Connection to #{url} failed"
      end

      # check for API errors
      case response.status
      when 401
        raise Adyen::AuthenticationError.new("Invalid API authentication; https://docs.adyen.com/user-management/how-to-get-the-api-key", request_data)
      when 403
        raise Adyen::PermissionError.new("Missing user permissions; https://docs.adyen.com/user-management/user-roles", request_data)
      end

      response
    end

    # add application_info for analytics
    def add_application_info(request_data)
      external_platform = {
        :adyenLibrary => {
          :name => Adyen::NAME,
          :version => Adyen::VERSION.to_s
        }
      }

      request_data[:applicationInfo] = external_platform
    end

    # services
    def checkout
      @checkout ||= Adyen::Checkout.new(self)
    end

    def checkout_utility
      @checkout_utility ||= Adyen::CheckoutUtility.new(self)
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
