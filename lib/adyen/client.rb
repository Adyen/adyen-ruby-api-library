# rubocop:disable Metrics/ParameterLists
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/ClassLength

require 'faraday'
require 'json'
require_relative './errors'
require_relative './result'

module Adyen
  class Client
    attr_accessor :ws_user, :ws_password, :api_key, :oauth_token, :client, :adapter
    attr_reader :env, :connection_options, :adapter_options

    def initialize(ws_user: nil, ws_password: nil, api_key: nil, oauth_token: nil, env: :live, adapter: nil, mock_port: 3001,
                   live_url_prefix: nil, mock_service_url_base: nil, connection_options: nil, adapter_options: nil)
      @ws_user = ws_user
      @ws_password = ws_password
      @api_key = api_key
      @oauth_token = oauth_token
      @env = env
      @adapter = adapter || Faraday.default_adapter
      @adapter_options = adapter_options || Faraday.default_adapter_options
      @mock_service_url_base = mock_service_url_base || "http://localhost:#{mock_port}"
      @live_url_prefix = live_url_prefix
      @connection_options = connection_options || Faraday::ConnectionOptions.new
    end

    # make sure that env can only be :live, :test, or :mock
    def env=(value)
      raise ArgumentError, "Invalid value for Client.env: '#{value}'' - must be one of [:live, :test, :mock]" unless %i[
        live test mock
      ].include? value

      @env = value
    end

    # remove 'https' from live_url_prefix if necessary
    def live_url_prefix=(value)
      value['https://'] = '' unless value['https://'].nil?
      @live_url_prefix = value
    end

    # base URL for API given service and @env
    def service_url_base(service)
      if @env == :mock
        @mock_service_url_base
      else
        case service
        when 'Checkout'
          url = "https://checkout-#{@env}.adyen.com"
          supports_live_url_prefix = true
        when 'Account', 'Fund', 'Notification', 'Hop'
          url = "https://cal-#{@env}.adyen.com/cal/services/#{service}"
          supports_live_url_prefix = false
        when 'Recurring', 'Payment', 'Payout', 'BinLookup', 'StoredValue', 'BalanceControlService'
          url = "https://pal-#{@env}.adyen.com/pal/servlet/#{service}"
          supports_live_url_prefix = true
        when 'PosTerminalManagement'
          url = "https://postfmapi-#{@env}.adyen.com/postfmapi/terminal"
          supports_live_url_prefix = false
        when 'DataProtectionService', 'DisputeService'
          url = "https://ca-#{@env}.adyen.com/ca/services/#{service}"
          supports_live_url_prefix = false
        when 'LegalEntityManagement'
          url = "https://kyc-#{@env}.adyen.com/lem"
          supports_live_url_prefix = false
        when 'BalancePlatform'
          url = "https://balanceplatform-api-#{@env}.adyen.com/bcl"
          supports_live_url_prefix = false
        when 'Transfers'
          url = "https://balanceplatform-api-#{@env}.adyen.com/btl"
          supports_live_url_prefix = false
        when 'Management'
          url = "https://management-#{@env}.adyen.com"
          supports_live_url_prefix = false
        when 'TerminalCloudAPI'
          url = "https://terminal-api-#{@env}.adyen.com"
          supports_live_url_prefix = false
        else
          raise ArgumentError, 'Invalid service specified'
        end

        if @live_url_prefix.nil? && (@env == :live) && supports_live_url_prefix
          raise ArgumentError,
                "Please set Client.live_url_prefix to the portion \
          of your merchant-specific URL prior to '-[service]-live.adyenpayments.com'"
        end

        if @env == :live && supports_live_url_prefix
          url.insert(8, "#{@live_url_prefix}-")
          url['adyen.com'] = 'adyenpayments.com'
        end

        url
      end
    end

    # construct full URL from service and endpoint
    def service_url(service, action, version)
      if service == "Checkout" && @env == :live
        return "#{service_url_base(service)}/checkout/v#{version}/#{action}"
      elsif version == nil
        return "#{service_url_base(service)}/#{action}"
      else
        return "#{service_url_base(service)}/v#{version}/#{action}"
      end
    end

    # send request to adyen API
    def call_adyen_api(service, action, request_data, headers, version, _with_application_info: false)
      # get URL for requested endpoint
      url = service_url(service, action.is_a?(String) ? action : action.fetch(:url), version)

      auth_type = auth_type(service, request_data)

      # initialize Faraday connection object
      conn = Faraday.new(url, @connection_options) do |faraday|
        faraday.adapter @adapter, **@adapter_options
        faraday.headers['Content-Type'] = 'application/json'
        faraday.headers['User-Agent'] = "#{Adyen::NAME}/#{Adyen::VERSION}"

        # set header based on auth_type and service
        auth_header(auth_type, faraday)

        # add optional headers if specified in request
        # will overwrite default headers if overlapping
        headers.map do |key, value|
          faraday.headers[key] = value
        end

        # add library headers
        faraday.headers['adyen-library-name'] = Adyen::NAME
        faraday.headers['adyen-library-version'] = Adyen::VERSION
      end
      # if json string convert to hash
      # needed to add applicationInfo
      request_data = JSON.parse(request_data) if request_data.is_a?(String)

      # convert to json
      request_data = request_data.to_json

      if action.is_a?(::Hash)
        if action.fetch(:method) == 'get'
          begin
            response = conn.get
          rescue Faraday::ConnectionFailed => e
            raise e, "Connection to #{url} failed"
          end
        end
        if action.fetch(:method) == 'delete'
          begin
            response = conn.delete
          rescue Faraday::ConnectionFailed => e
            raise e, "Connection to #{url} failed"
          end
        end
        if action.fetch(:method) == 'patch'
          begin
            response = conn.patch do |req|
              req.body = request_data
            end
          rescue Faraday::ConnectionFailed => e
            raise e, "Connection to #{url} failed"
          end
        end
        if action.fetch(:method) == 'post'
          # post request to Adyen
          begin
            response = conn.post do |req|
              req.body = request_data
            end
          rescue Faraday::ConnectionFailed => e
            raise e, "Connection to #{url} failed"
          end
        end
      else
        begin
          response = conn.post do |req|
            req.body = request_data
          end
        rescue Faraday::ConnectionFailed => e
          raise e, "Connection to #{url} failed"
        end
      end
      # check for API errors
      case response.status
      when 401
        raise Adyen::AuthenticationError.new(
          'Invalid API authentication; https://docs.adyen.com/user-management/how-to-get-the-api-key', request_data
        )
      when 403
        raise Adyen::PermissionError.new('Missing user permissions; https://docs.adyen.com/user-management/user-roles',
                                         request_data, response.body)
      end

      # delete has no response.body (unless it throws an error)
      if response.body.nil? || response.body === ''
        AdyenResult.new('{}', response.headers, response.status)
      # terminal API async call returns always 'ok'
      elsif response.body === 'ok'
        AdyenResult.new('{}', response.headers, response.status)
      else
        AdyenResult.new(response.body, response.headers, response.status)
      end
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
      @stored_value ||= Adyen::StoredValue.new(self)
    end

    def balance_control_service
      @balance_control_service ||= Adyen::BalanceControlService.new(self)
    end

    def terminal_cloud_api
      @terminal_cloud_api ||= Adyen::TerminalCloudAPI.new(self)
    end

    private

    def auth_header(auth_type, faraday)
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
      when "oauth"
        faraday.headers["Authorization"] = "Bearer #{@oauth_token}"
      end
    end

    def auth_type(service, request_data)
      # make sure valid authentication has been provided
      validate_auth_type(service, request_data)
      # Will prioritize authentication methods in this order:
      # api-key, oauth, basic
      return "api-key" unless @api_key.nil?
      return "oauth" unless @oauth_token.nil?
      "basic"
    end

    def validate_auth_type(service, request_data)
      # ensure authentication has been provided
      if @api_key.nil? && @oauth_token.nil? && (@ws_password.nil? || @ws_user.nil?)
        raise Adyen::AuthenticationError.new(
          'No authentication found - please set api_key, oauth_token, or ws_user and ws_password',
          request_data
        )
      end
      if service == "PaymentSetupAndVerification" && @api_key.nil? && @oauth_token.nil? && @ws_password.nil? && @ws_user.nil?
        raise Adyen::AuthenticationError.new('Checkout service requires API-key or oauth_token', request_data),
              'Checkout service requires API-key or oauth_token'
      end
    end
  end
end
# rubocop:enable all
