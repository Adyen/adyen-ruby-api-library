# Adyen API Library for Ruby

The Adyen API Library for Ruby lets you easily work with Adyen's API.

## Integration

The Library supports all APIs under the following services:

* checkout
* checkout utility
* payments
* modifications
* payouts
* recurring
* marketpay

## Requirements

Built for Ruby >= 2.1

## Installation

The sole dependency is faraday for http communication - run `bundle install` to install faraday if you don't already have it

To validate functionality of client, use `bundle install --with development` and `rspec` to run mock API tests.

## Documentation

Follow the rest of our guides from the [documentation](https://adyen.github.io/adyen-ruby-api-library/) on how to use this library.

## Usage

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
}')
```

### Marketpay
The Marketpay sub-services are children of the marketpay member of the initial object, for instance:
```ruby
adyen.marketpay.account.close_account('{
  "accountCode": "CODE_OF_ACCOUNT"
}')
```

## Validation
Requests are checked to make sure that all top-level required fields are present.  In addition, the presence of the correct method of authentication is confirmed before making the API call (wrong credentials are not caught).

## Support

If you have any problems, questions or suggestions, create an issue here or send your inquiry to support@adyen.com.
  
## Licence

MIT license. For more information, see the LICENSE file.
