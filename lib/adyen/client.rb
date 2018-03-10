require 'faraday'

module Adyen

	class Client
		attr_accessor :user, :password, :api_key, :env, :client, :adapter
		attr_accessor :checkout

		def initialize(user=nil, password=nil, api_key=nil, env=:live, adapter=nil)
			@user = user
			@password = password
			@api_key = api_key
			@env = env
			@adapter = Faraday.default_adapter
		end

		def env=(value)
			if [:live, :test].include? value
				@env = value
			else
				raise ArgumentError, "Invalid value for Adyen.env: '#{value}' - must be one of [:live, :test]"
			end
		end

		def service_url_base(service, action)
			if service == "PaymentSetupAndVerification"
				"https://checkout-#{@env}.adyen.com/services/#{service}/#{action}"
			else
				"https://pal-#{@env}.adyen.com/pal/servlet/#{service}/#{action}"
			end
		end

		def call_adyen_api(service, action, request_data)
			url = service_url_base(service, action)
			puts url
			
			# make sure right authentication has been provided
			case service
			when "PaymentSetupAndVerification"
				raise ArgumentError, "Checkout API-key not set" unless not @api_key.nil?
				auth_type = "x-api-key"

			when "Payment", "Recurring", "Payout"
				raise ArgumentError, "Client.user and client.password must be set" unless not @password.nil? and not @user.nil?
				auth_type = "basic"
			end

			# initialize Faraday connection object
			conn = Faraday.new(:url => url) do |faraday|
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
			response = conn.post do |req|
				req.body = request_data
			end

    	end

		def checkout
			@checkout ||= Adyen::Checkout.new(self)
		end
	end
end
