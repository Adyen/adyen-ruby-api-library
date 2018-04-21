module Adyen
  class Service
    attr_accessor :service

    def initialize(client, version, service, method_action_pairs)
      @client = client
      @version = version
      @service = service

      # dynamically create API methods
      method_action_pairs.each do |pair|
        define_singleton_method pair[0] do |request|
          action = pair[1]
          @client.call_adyen_api(@service, action, request, @version)
        end
      end
    end

  end
end
