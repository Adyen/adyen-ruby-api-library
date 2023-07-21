require_relative "service"

module Adyen
  class AccessControlServer < Service
    attr_accessor :version
    DEFAULT_VERSION = 1

    def initialize(client, version = DEFAULT_VERSION)
      @service = "AccessControlServer"
      @client = client
      @version = version
    end

    def finalize_authentication(request_params, challenge_id)
      action = { method: 'patch', url: "challenges/" + challenge_id }

      @client.call_adyen_api(@service, action, request_params, {}, @version)
    end
  end
end
