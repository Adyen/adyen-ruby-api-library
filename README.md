# Adyen API Library for Ruby

# !!! Not Working !!!
The Adyen API Library for Ruby enables you to easily work with Adyen's API.

## Requirements

Ruby 2.0>=

## Getting Started
### Setup
```ruby
require 'adyen'

adyen = Adyen::Client.new
adyen.api_key = 'AF5XXXXXXXXXXXXXXXXXXXX'
```

### Make a Payment
```ruby

adyen.Checkout.payments({
  :amount => {
    :value => 1000,
    :currency => "USD"
  },
  :merchantReference => "your_unqiue_ref",
  :merchantAccount => "YourMerchantAccount",
  :card => {
    :number => 4111111111111111,
    :expiryMonth => 08,
    :expiryYear => 09,
    :holderName => "John Doe"
  }
})
```

## Developmnet and Testing

Install requirements with ```bundle install```

After adding your code, add and adjust test accordingle in `/spec/adyen_spec.rb`. 
To run the test, run ```bundle exec rake spec```
