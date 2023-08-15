module Adyen
  class Service
    attr_accessor :service, :version

    # add snake case to camel case converter to String
    # to convert rubinic method names to Adyen API methods
    #
    # i.e. snake_case -> snakeCase
    # note that the first letter is not capitalized as normal
    def self.action_for_method_name(method_name)
      method_name.to_s.gsub(/_./) { |x| x[1].upcase }
    end

    def initialize(client, version, service, method_names = [], with_application_info = [])
      @client = client
      @version = version
      @service = service

      # dynamically create API methods
      method_names.each do |method_name|
        define_singleton_method method_name do |request, headers = {}|
          action = self.class.action_for_method_name(method_name)
          @client.call_adyen_api(@service, action, request, headers, @version,
                                 _with_application_info: with_application_info.include?(method_name))
        end
      end
    end

    # create query parameter from a hash
    def create_query_string(arr)
      "?#{URI.encode_www_form(arr)}"
    end
  end
end
