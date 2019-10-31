require 'json'

module Adyen
  class AdyenResult
    attr_reader :response, :header, :status

    def initialize(response, header, status)
      @response = JSON.parse(response)

      # `header` in Faraday response is not a JSON string, but rather a
      # Faraday `Headers` object. Convert first before parsing
      @header = JSON.parse(header.to_json)
      @status = status
    end
  end
end
