require 'json'

module Adyen
  class AdyenResponse
    attr_reader :body, :header, :status

    def initialize(body, header, status)
      @body = JSON.parse(body)

      # `header` in Faraday response is not a JSON string, but rather a
      # Faraday `Headers` object. Convert first before parsing
      @header = JSON.parse(header.to_json)
      @status = status
    end
  end
end
