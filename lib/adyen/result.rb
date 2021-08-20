require 'json'

module Adyen
  class AdyenResult
    attr_reader :response, :header, :status

    def initialize(response, header, status)
        # `header` in Faraday response is not a JSON string, but rather a
        # Faraday `Headers` object. Convert first before parsing
        @header = JSON.parse(header.to_json, object_class: HashWithAccessors)


      if status == 204
        @status = status
        @response = ""
      else
        @response = JSON.parse(response, object_class: HashWithAccessors)
        @status = status
      end
    end
  end
end
