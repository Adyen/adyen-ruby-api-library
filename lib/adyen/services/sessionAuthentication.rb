require_relative 'sessionAuthentication/session_authentication_api'

module Adyen

  # NOTE: This class is auto generated by OpenAPI Generator
  # Ref: https://openapi-generator.tech
  #
  # Do not edit the class manually.
  class SessionAuthentication
    attr_accessor :service, :version

    DEFAULT_VERSION = 1
    def initialize(client, version = DEFAULT_VERSION)
      @service = 'SessionAuthentication'
      @client = client
      @version = version
    end

    def session_authentication_api
      @session_authentication_api ||= Adyen::SessionAuthenticationApi.new(@client, @version)
    end

  end
end
