# Adyen API Library for Ruby

The Adyen API Library for Ruby lets you easily work with Adyen's API.

Performs validation that required authentication parameters are present, as well as top-level fields required for specific requests.

## Requirements

Built for Ruby >= 2.0

The sole dependency is faraday for http communication - run `bundle install` to install faraday if you don't already have it

To validate functionality of client, use `bundle install --with development` and `rspec` to run mock API tests.

## Getting Started

### Create a client to connect to the Adyen API
```ruby
require 'adyen'

adyen = Adyen::Client.new

# for API-key based implementations
adyen.api_key = 'AF5XXXXXXXXXXXXXXXXXXXX'

# for basic-auth based implementations
adyen.ws_user = 'ws@Company.Adyen'
adyen.ws_password = 'super_secure_password123'
```

### Make a Payment
```ruby
adyen.checkout.payments('{
  "amount": {
    "value": 1000,
    "currency": "USD"
  },
  "merchantReference": "your_unqiue_ref",
  "merchantAccount": "YourMerchantAccount",
  "card": {
    "number": 4111111111111111,
    "expiryMonth": "08",
    "expiryYear": "2018",
    "holderName": "Simon Hopper"
  }
})
```