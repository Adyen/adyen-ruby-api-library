# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity

# This utility method inherits from Hash, but allows keys to be read
# and updated with dot notation. Usage is entirely optional (i.e.,  hash values
# can still be accessed via symbol and string keys).
#
# Based on: https://gist.github.com/winfred/2185384#file-ruby-dot-hash-access-rb
module Adyen
  class HashWithAccessors < Hash
    def method_missing(method, *args)
      string_key = method.to_s.sub(/=\z/, '')
      sym_key = string_key.to_sym

      key = if key?(string_key)
              string_key
            elsif key?(sym_key)
              sym_key
            end

      return super unless key

      assignment = sym_key != method

      if assignment
        raise ArgumentError, "wrong number of arguments (given #{args.size}, expected 1)" unless args.size == 1

        self[key] = args.first
      else
        raise ArgumentError, "wrong number of arguments (given #{args.size}, expected 0)" unless args.empty?

        self[key]
      end
    end

    def respond_to_missing?(method, include_private = false)
      string_key = method.to_s.sub(/=\z/, '')
      key?(string_key) || key?(string_key.to_sym) || super
    end
  end
end
# rubocop:enable all
