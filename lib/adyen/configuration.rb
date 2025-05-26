module Adyen
  class Configuration
    attr_accessor :connection_options

    def initialize
      set_defaults
    end

    def set_defaults
      @connection_options = {
        timeout: 60,        # total request timeout in seconds
        open_timeout: 30,   # time to establish a connection
        read_timeout: 30,   # time to wait for a response
        write_timeout: 30   # time to send data
      }
    end

    # Allow updating timeout options
    def update_connection_options(new_options)
      @connection_options.merge!(new_options)
    end
  end
end
