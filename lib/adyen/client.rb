require 'faraday'


module Adyen

	class Client
		attr_accessor :user, :password, :api_key, :env, :client, :adapter

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
			"https://pal-#{@env}.adyen.com/pal/servlet/#{service}/#{endpoint}"
		end

		def call_adyen_api(service, action, request)
			url = service_url_base(service, action)
    	end

		def checkout
			@checkout ||= Adyen::Checkout.new(self)
		end
	end
end
