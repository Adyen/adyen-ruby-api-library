require 'spec_helper'

RSpec.describe Adyen::Deprecation do
  describe '.warn' do
    around do |example|
      previous = Warning[:deprecated]
      example.run
    ensure
      Warning[:deprecated] = previous
    end

    context 'message formatting' do
      before { Warning[:deprecated] = true }

      it 'formats a warning with the method name only' do
        expect { described_class.warn(:get_payment_methods) }
          .to output(/\[DEPRECATED\] `get_payment_methods` is deprecated\n/).to_stderr
      end

      it 'formats a warning with since' do
        expect { described_class.warn(:get_payment_methods, since: 'Adyen Checkout API v67') }
          .to output(/\[DEPRECATED\] `get_payment_methods` is deprecated since Adyen Checkout API v67\n/).to_stderr
      end

      it 'formats a warning with message' do
        expect { described_class.warn(:get_payment_methods, message: 'Use `payments` instead.') }
          .to output(/\[DEPRECATED\] `get_payment_methods` is deprecated\. Use `payments` instead\.\n/).to_stderr
      end

      it 'formats a warning with both since and message' do
        expect do
          described_class.warn(:get_payment_methods,
                               since: 'Adyen Checkout API v67',
                               message: 'Use `payments` instead.')
        end
          .to output(/\[DEPRECATED\] `get_payment_methods` is deprecated since Adyen Checkout API v67\. Use `payments` instead\.\n/).to_stderr
      end
    end

    context 'when Warning[:deprecated] is true' do
      it 'writes the formatted message to stderr' do
        Warning[:deprecated] = true
        expect { described_class.warn(:foo, since: 'Adyen Checkout API v67') }
          .to output(/\[DEPRECATED\] `foo` is deprecated since Adyen Checkout API v67\n/).to_stderr
      end

      it 'attributes the warning to the call site (file:line: warning: format)' do
        Warning[:deprecated] = true
        expect { described_class.warn(:foo, since: 'Adyen Checkout API v67') }
          .to output(/\A.+:\d+: warning: \[DEPRECATED\] `foo`/).to_stderr
      end

      it 'emits through Warning.warn tagged with the :deprecated category' do
        Warning[:deprecated] = true
        expect(Warning).to receive(:warn).with(
          /:\d+: warning: \[DEPRECATED\] `foo` is deprecated since Adyen Checkout API v67\n/,
          category: :deprecated
        )
        described_class.warn(:foo, since: 'Adyen Checkout API v67')
      end
    end

    context 'when Warning[:deprecated] is false' do
      it 'writes nothing to stderr' do
        Warning[:deprecated] = false
        expect { described_class.warn(:foo, since: 'Adyen Checkout API v67') }
          .not_to output.to_stderr
      end
    end

    context 'silencing' do
      around do |example|
        original_env = ENV.fetch('ADYEN_SILENCE_DEPRECATIONS', nil)
        example.run
      ensure
        described_class.silenced = nil
        if original_env.nil?
          ENV.delete('ADYEN_SILENCE_DEPRECATIONS')
        else
          ENV['ADYEN_SILENCE_DEPRECATIONS'] = original_env
        end
      end

      before { Warning[:deprecated] = true }

      it 'emits nothing when silenced is true, even with the category enabled' do
        described_class.silenced = true
        expect { described_class.warn(:foo, since: 'Adyen Checkout API v67') }
          .not_to output.to_stderr
      end

      it 'is silenced when ADYEN_SILENCE_DEPRECATIONS has a truthy value' do
        ENV['ADYEN_SILENCE_DEPRECATIONS'] = '1'
        expect { described_class.warn(:foo, since: 'Adyen Checkout API v67') }
          .not_to output.to_stderr
      end

      it 'is not silenced when ADYEN_SILENCE_DEPRECATIONS has a falsy value' do
        ENV['ADYEN_SILENCE_DEPRECATIONS'] = '0'
        expect { described_class.warn(:foo, since: 'Adyen Checkout API v67') }
          .to output(/\[DEPRECATED\] `foo` is deprecated since Adyen Checkout API v67\n/).to_stderr
      end

      it 'lets the attribute override the environment variable' do
        ENV['ADYEN_SILENCE_DEPRECATIONS'] = '1'
        described_class.silenced = false
        expect { described_class.warn(:foo, since: 'Adyen Checkout API v67') }
          .to output(/\[DEPRECATED\] `foo` is deprecated since Adyen Checkout API v67\n/).to_stderr
      end
    end
  end
end
