require_relative "lib/adyen/version"

Gem::Specification.new do |spec|
  spec.name          = "adyen-ruby-api-client"
  spec.version       = Adyen::VERSION
  spec.authors       = ["Adyen"]
  spec.email         = [""]

  spec.summary       = "API Library for Adyen APIs"
  spec.description   = "A ruby library from Adyen that simplifies integrating with the API, including Checkout, Marketpay, payments, recurring, and payouts.  For support please reach out to support@adyen.com.  If you'd like to contribute please submit a comment or pull request at https://github.com/Adyen/adyen-ruby-api-library."
  spec.homepage      = "https://www.adyen.com"
  spec.license       = "MIT"
  
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activesupport"
end
