module Adyen
  class Service
    attr_accessor :service, :version

    def initialize(client, version, service, method_names)
      @client = client
      @version = version
      @service = service

      # dynamically create API methods
      method_names.each do |method_name|
        define_singleton_method method_name do |request|
          action = method_name.to_s.to_camel_case
          @client.call_adyen_api(@service, action, request, @version)
        end
      end
    end
  end
end
