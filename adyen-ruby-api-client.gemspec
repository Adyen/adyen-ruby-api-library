require_relative "lib/adyen/version"

Gem::Specification.new do |spec|
  spec.name          = "adyen-ruby-api-client"
  spec.version       = Adyen::VERSION
  spec.authors       = ["Adyen"]
  spec.email         = [""]

  spec.summary       = "Adyen's Official Ruby API Library"
  spec.description   = "Simplifies integrating with the Adyen API, including Checkout, Marketpay, payments, recurring, and payouts.  For support please reach out to support@adyen.com.  If you'd like to contribute please submit a comment or pull request at https://github.com/Adyen/adyen-ruby-api-library."
  spec.homepage      = "https://www.adyen.com"
  spec.license       = "MIT"

  spec.metadata = {
    "documentation_uri":  "https://adyen.github.io/adyen-ruby-api-library/",
    "homepage_uri":       "https://www.adyen.com",
    "source_code_uri":    "value", "https://github.com/Adyen/adyen-ruby-api-library"
  }
  
  spec.files = `git ls-files`.split("\n")

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activesupport"
end
