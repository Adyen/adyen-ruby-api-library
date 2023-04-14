require_relative 'payouts/initialization_api'
require_relative 'payouts/instant_payouts_api'
require_relative 'payouts/reviewing_api'

module Adyen
    

    class Payouts
        attr_accessor :service, :version
        
        DEFAULT_VERSION = 68
        def initialize(client, version = DEFAULT_VERSION)
        @service = "Payouts"
        @client = client
        @version = version
        end

        def initialization_api
            @initialization_api ||= Adyen::InitializationApi.new(@client, @version)
        end

        def instant_payouts_api
            @instant_payouts_api ||= Adyen::InstantPayoutsApi.new(@client, @version)
        end

        def reviewing_api
            @reviewing_api ||= Adyen::ReviewingApi.new(@client, @version)
        end

    end
end