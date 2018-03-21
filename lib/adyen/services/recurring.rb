module Adyen
	class Recurring
		def initialize(client)
			@client = client
			@service = 'Recurring'
		end
		def listRecurringDetails(request)
			action = 'listRecurringDetails'
			@client.call_adyen_api(@service, action, request)
		end
		def disable(request)
			action = 'disable'
			@client.call_adyen_api(@service, action, request)
		end
		def storeToken(request)
			action = 'storeToken'
			@client.call_adyen_api(@service, action, request)
		end
		def scheduleAccountUpdater(request)
			action = 'scheduleAccountUpdater'
			@client.call_adyen_api(@service, action, request)
		end
	end
end