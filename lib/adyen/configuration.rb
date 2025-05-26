module Adyen
    class Configuration
        attr_accessor :connection_options
        
        def initialize
            set_defaults
        end

        def set_defaults
            @connection_options = {
                request: {
                timeout: 60,        # default total request timeout
                open_timeout: 30,   # default connection timeout
                read_timeout: 30,   # default read timeout
                write_timeout: 30   # default write timeout
            }
        }
        end

        # method to override or merge options
        def update_connection_options(new_options)
            @connection_options = deep_merge(@connection_options, new_options)
        end

        private

        # deep merge helper
        def deep_merge(hash1, hash2)
            hash1.merge(hash2) do |key, oldval, newval|
                oldval.is_a?(Hash) && newval.is_a?(Hash) ? deep_merge(oldval, newval) : newval
            end
        end
    end
end
