module Adyen
  # Helper module for emitting deprecation warnings for deprecated API methods.
  module Deprecation
    # `warn` only accepts the `category` keyword on Ruby >= 3.0.
    CATEGORY_SUPPORT = (RUBY_VERSION.split('.').map(&:to_i) <=> [3, 0]) >= 0

    # Set to true to silence all Adyen deprecation warnings, regardless of
    # Warning[:deprecated]. Explicitly setting this attribute (true or false)
    # overrides the ADYEN_SILENCE_DEPRECATIONS environment variable.
    def self.silenced=(value)
      @silenced = value
    end

    # True when deprecation warnings are silenced, either via the attribute or,
    # when the attribute was never set, via the ADYEN_SILENCE_DEPRECATIONS
    # environment variable ("1", "true" or "yes", case-insensitive).
    def self.silenced?
      return @silenced unless @silenced.nil?

      %w[1 true yes].include?(ENV.fetch('ADYEN_SILENCE_DEPRECATIONS', '').downcase)
    end

    # Emits a deprecation warning for a deprecated method.
    #
    # @param method_name [Symbol, String] name of the deprecated method
    # @param since [String, nil] e.g. "Adyen Checkout API v67"
    # @param message [String, nil] additional guidance, e.g. the alternative to use
    def self.warn(method_name, since: nil, message: nil)
      return if silenced?

      text = "[DEPRECATED] `#{method_name}` is deprecated"
      text += " since #{since}" if since
      text += ". #{message}" if message
      if CATEGORY_SUPPORT
        Kernel.warn(text, category: :deprecated, uplevel: 2)
      elsif Warning[:deprecated]
        # Ruby 2.7 exposes the :deprecated flag but cannot emit into the category,
        # so honour the flag by hand to keep the behaviour consistent.
        Kernel.warn(text, uplevel: 2)
      end
    end
  end
end
