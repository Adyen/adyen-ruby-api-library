require_relative "lib/adyen/version"

Gem::Specification.new do |spec|
  spec.name          = "adyen"
  spec.version       = Adyen::VERSION
  spec.authors       = ["Adyen"]
  spec.email         = [""]

  spec.summary       = "API Library for Adyen APIs"
  spec.description   = "Simplify Adyen API Integration"
  spec.homepage      = "https://www.adyen.com"
  spec.license       = "MIT"
  
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activesupport"
end
