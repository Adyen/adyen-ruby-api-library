require "./adyen/client.rb"

class Adyen

	attr_accessor :user, :password, :checkout_api_key, :env, :client

	def initialize(user=nil, password=nil, checkout_api_key=nil, env=:live)
		@user = user
		@password = password
		@checkout_api_key = checkout_api_key
		@env = env
		@client = Adyen::Client.new
	end

	def env=(value)
		if [:live, :test].include? value
			@env = value
		else
			raise ArgumentError, "Invalid value for Adyen.env: '#{value}' - must be one of [:live, :test]"
		end
	end

	def payment_url_base
		"https://pal-#{@env}.adyen.com/pal/servlet/Payment/"
	end

	def recurring_url_base
		"https://pal-#{@env}.adyen.com/pal/servlet/Recurring/"
	end

	def checkout_url_base
		"https://checkout-#{@env}.adyen.com/services/PaymentSetupAndVerification/"
	end

end