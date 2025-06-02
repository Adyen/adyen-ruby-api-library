# frozen_string_literal: true

source 'https://rubygems.org'

ruby '>= 2.7.0'

# For Ruby ≥ 3.2, we use Faraday 2.x; else we stick with 1.8.x
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.2')
  gem 'faraday', '~> 2.0'
else
  gem 'faraday', '~> 1.8'
end

gem 'activesupport', group: :development
gem 'bundler', group: :development
gem 'rspec', group: :development
gem 'webmock', group: :development
