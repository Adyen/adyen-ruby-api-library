# require "adyen/client"

module Adyen

	@env = "live"

	class << self
		attr_accessor :ws_user, :ws_pass, :env, :merchant_account
	end

	def self.api_url_base
		"https://pal-%s.adyen.com/pal/servlet/Payment/" % @env
	end

	def self.checkout_url_base
		"https://checkout-%s.adyen.com/services/PaymentSetupAndVerification/" % @env
	end

	def self.hpp_url_base
		"https://%s.adyen.com/hpp/" % @env
	end
end