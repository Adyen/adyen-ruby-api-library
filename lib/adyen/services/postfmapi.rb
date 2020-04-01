require_relative 'service'

module Adyen
  class PosTerminalManagement < Service
    attr_accessor :version
    DEFAULT_VERSION = 1

    def initialize(client, version = DEFAULT_VERSION)
      service = 'Terminal'
      method_names = [
        :assign_terminals,
        :find_terminal,
        :get_terminals_under_account
      ]

      super(client, version, service, method_names)
    end
  end
end
