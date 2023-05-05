require "faraday"
require "json"
require_relative "./errors"
require_relative "./result"

module Adyen
  class Client
    attr_accessor :ws_user, :ws_password, :api_key, :client, :adapter, :live_url_prefix
    attr_reader :env, :connection_options

    def initialize(ws_user: nil, ws_password: nil, api_key: nil, env: :live, adapter: nil, mock_port: 3001, live_url_prefix: nil, mock_service_url_base: nil, connection_options: nil)
      @ws_user = ws_user
      @ws_password = ws_password
      @api_key = api_key
      @env = env
      @adapter = adapter || Faraday.default_adapter
      @mock_service_url_base = mock_service_url_base || "http://localhost:#{mock_port}"
      @live_url_prefix = live_url_prefix
      @connection_options = connection_options || Faraday::ConnectionOptions.new
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
      if @env == :mock
        @mock_service_url_base
      else
        case service
        when "Checkout"
          url = "https://checkout-#{@env}.adyen.com"
          supports_live_url_prefix = true
        when "Account", "Fund", "Notification", "Hop"
          url = "https://cal-#{@env}.adyen.com/cal/services/#{service}"
          supports_live_url_prefix = false
        when "Recurring", "Payment", "Payout", "BinLookup", "StoredValue", "BalanceControlService"
          url = "https://pal-#{@env}.adyen.com/pal/servlet/#{service}"
          supports_live_url_prefix = true
        when "PosTerminalManagement"
          url = "https://postfmapi-#{@env}.adyen.com/postfmapi/terminal"
          supports_live_url_prefix = false
        when "DataProtectionService", "DisputeService"
          url = "https://ca-#{@env}.adyen.com/ca/services/#{service}"
          supports_live_url_prefix = false
        when "LegalEntityManagement"
          url = "https://kyc-#{@env}.adyen.com/lem"
          supports_live_url_prefix = false
        when "BalancePlatform" 
          url = "https://balanceplatform-api-#{@env}.adyen.com/bcl"
          supports_live_url_prefix = false
        when "Transfers"
          url = "https://balanceplatform-api-#{@env}.adyen.com/btl"
          supports_live_url_prefix = false
        when "Management"
          url = "https://management-#{@env}.adyen.com"
          supports_live_url_prefix = false
        else
          raise ArgumentError, "Invalid service specified"
        end
        
        raise ArgumentError, "Please set Client.live_url_prefix to the portion of your merchant-specific URL prior to '-[service]-live.adyenpayments.com'" \
         if @live_url_prefix.nil? and @env == :live and supports_live_url_prefix
        if @env == :live && supports_live_url_prefix
          url.insert(8, "#{@live_url_prefix}-")
          url["adyen.com"] = "adyenpayments.com"
        end

        return url
      end
    end

    # construct full URL from service and endpoint
    def service_url(service, action, version)
      "#{service_url_base(service)}/v#{version}/#{action}"
    end

    # send request to adyen API
    def call_adyen_api(service, action, request_data, headers, version, with_application_info = false)
      # get URL for requested endpoint
      url = service_url(service, action.is_a?(String) ? action : action.fetch(:url), version)

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
      conn = Faraday.new(url, @connection_options) do |faraday|
        faraday.adapter @adapter
        faraday.headers["Content-Type"] = "application/json"
        faraday.headers["User-Agent"] = Adyen::NAME + "/" + Adyen::VERSION

        # set auth type based on service
        case auth_type
        when "basic"
          if Gem::Version.new(Faraday::VERSION) >= Gem::Version.new('2.0')
            # for faraday 2.0 and higher
            faraday.request :authorization, :basic, @ws_user, @ws_password
          else
            # for faraday 1.x
            faraday.basic_auth(@ws_user, @ws_password)
          end
        when "api-key"
          faraday.headers["x-api-key"] = @api_key
        end

        # add optional headers if specified in request
        # will overwrite default headers if overlapping
        headers.map do |key, value|
          faraday.headers[key] = value
        end

        # add library headers
        faraday.headers["adyen-library-name"] = Adyen::NAME
        faraday.headers["adyen-library-version"] = Adyen::VERSION
      end
      # if json string convert to hash
      # needed to add applicationInfo
      if request_data.is_a?(String)
        request_data = JSON.parse(request_data)
      end


      # convert to json
      request_data = request_data.to_json

      if action.is_a?(::Hash)
        if action.fetch(:method) == "get"
          begin
            response = conn.get
          rescue Faraday::ConnectionFailed => connection_error
            raise connection_error, "Connection to #{url} failed"
          end
        end
        if action.fetch(:method) == "delete"
          begin
            response = conn.delete
          rescue Faraday::ConnectionFailed => connection_error
            raise connection_error, "Connection to #{url} failed"
          end
        end
        if action.fetch(:method) == "patch"
          begin
            response = conn.patch do |req|
              req.body = request_data
            end
          rescue Faraday::ConnectionFailed => connection_error
            raise connection_error, "Connection to #{url} failed"
          end
        end
       if action.fetch(:method) == 'post'
        # post request to Adyen
        begin
          response = conn.post do |req|
            req.body = request_data
          end # handle client errors
        rescue Faraday::ConnectionFailed => connection_error
          raise connection_error, "Connection to #{url} failed"
        end
       end 
      else
        begin
          response = conn.post do |req|
            req.body = request_data
          end # handle client errors
        rescue Faraday::ConnectionFailed => connection_error
          raise connection_error, "Connection to #{url} failed"
        end
      end
      # check for API errors
      case response.status
      when 401
        raise Adyen::AuthenticationError.new("Invalid API authentication; https://docs.adyen.com/user-management/how-to-get-the-api-key", request_data)
      when 403
        raise Adyen::PermissionError.new("Missing user permissions; https://docs.adyen.com/user-management/user-roles", request_data, response.body)
      end
      
      # delete has no response.body (unless it throws an error)
      if response.body == nil
        formatted_response = AdyenResult.new("{}", response.headers, response.status)
      else
        formatted_response = AdyenResult.new(response.body, response.headers, response.status)
      end
      
      formatted_response
    end


    # services
    def checkout
      @checkout ||= Adyen::Checkout.new(self)
    end

    def payment
      @payment ||= Adyen::Payment.new(self)
    end

    def payout
      @payout ||= Adyen::Payout.new(self)
    end

    def recurring
      @recurring ||= Adyen::Recurring.new(self)
    end

    def marketpay
      @marketpay ||= Adyen::Marketpay::Marketpay.new(self)
    end

    def pos_terminal_management
      @pos_terminal_management ||= Adyen::PosTerminalManagement.new(self)
    end

    def data_protection
      @data_protection ||= Adyen::DataProtection.new(self)
    end

    def dispute
      @dispute ||= Adyen::Dispute.new(self)
    end

    def bin_lookup
      @bin_lookup ||= Adyen::BinLookup.new(self)
    end

    def legal_entity_management
      @legal_entity_management ||= Adyen::LegalEntityManagement.new(self)
    end

    def balance_platform
      @balance_platform ||= Adyen::BalancePlatform.new(self)
    end

    def transfers
      @transfers ||= Adyen::Transfers.new(self)
    end

    def management
      @management ||= Adyen::Management.new(self)
    end
    
    def stored_value
      @stored_value ||=Adyen::StoredValue.new(self)
    end

    def balance_control_service
      @balance_control_service ||=Adyen::BalanceControlService.new(self)
    end
  end
end
