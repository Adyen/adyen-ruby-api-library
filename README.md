# Adyen API Library for Ruby

The Adyen API Library for Ruby lets you easily work with Adyen's API.

## Requirements

Built for Ruby >= 2.1

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

## List of supported methods
####checkout:
- payments
- payments.details
- payment_methods
- setup
- verify

####payments:
- authorise
- authorise3d

####modifications:
- capture
- cancel
- refund
- cancel_or_refund
- adjust_authorisation

####payouts:
- confirm_third_party
- decline_third_party
- store_detail
- submit_third_party
- store_detail_and_submit_third_party

####recurring:
- list_recurring_details
- disable
- store_token

####marketpay.account:
- create_account_holder
- get_account_holder
- update_account_holder
- update_account_holder_state
- suspend_account_holder
- un_suspend_account_holder
- close_account_holder
- create_account
- update_account
- close_account
- upload_document
- get_uploaded_documents
- delete_bank_accounts
- delete_shareholders

####marketpay.fund:
- account_holder_balance
- account_holder_transaction_list
- payout_account_holder
- transfer_funds
- setup_beneficiary
- refund_not_paid_out_transfers

####marketpay.notification:
- create_notification_configuration
- get_notification_configuration
- get_notification_configuration_list
- test_notification_configuration
- update_notification_configuration
- delete_notification_configurations
