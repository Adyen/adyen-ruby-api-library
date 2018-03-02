require 'faraday'

class Adyen

	class Client

		attr_accessor :adapter

		def initialize(adapter=nil)
			@adapter = Faraday.default_adapter
		end

	end

end