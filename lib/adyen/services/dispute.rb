require_relative 'service'

module Adyen
  class Dispute < Service
    attr_accessor :version

    DEFAULT_VERSION = 30

    def initialize(client, version = DEFAULT_VERSION)
      service = 'DisputeService'
      method_names = %i[
        retrieve_applicable_defense_reasons
        supply_defense_document
        delete_dispute_defense_document
        defend_dispute
      ]

      super(client, version, service, method_names)
    end
  end
end
