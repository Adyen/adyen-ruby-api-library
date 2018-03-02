# require "adyen/client"

module Adyen

	@env = "live"

	class << self
		attr_accessor :ws_user, :ws_pass, :env, :merchant_account
	end

	def self.payment_url_base
		"https://pal-%s.adyen.com/pal/servlet/Payment/" % @env
	end

	def self.recurring_url_base
		"https://pal-%s.adyen.com/pal/servlet/Recurring/" % @env
	end

	def self.checkout_url_base
		"https://checkout-%s.adyen.com/services/PaymentSetupAndVerification/" % @env
	end

end