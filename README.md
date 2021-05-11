# Adyen API Library for Ruby

The Adyen API Library for Ruby lets you easily work with Adyen's API.

## Integration

The Library supports all APIs under the following services:

* checkout
* payments
* modifications
* payouts
* recurring
* marketpay
* postfmapi
* data_protection
* dispute
* bin_lookup

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
require 'adyen-ruby-api-library'

adyen = Adyen::Client.new

# for API-key based implementations
adyen.api_key = 'AF5XXXXXXXXXXXXXXXXXXXX'

# for basic-auth based implementations
adyen.ws_user = 'ws@Company.Adyen'
adyen.ws_password = 'super_secure_password123'
```

### Make a Payment
```ruby
response = adyen.checkout.payments({
  :amount => {
    :currency => "EUR",
    :value => 1000
  },
  :reference => "Your order number",
  :paymentMethod => {
    :type => "scheme",
    :encryptedCardNumber => "adyenjs_0_1_18$MT6ppy0FAMVMLH...",
    :encryptedExpiryMonth => "adyenjs_0_1_18$MT6ppy0FAMVMLH...",
    :encryptedExpiryYear => "adyenjs_0_1_18$MT6ppy0FAMVMLH...",
    :encryptedSecurityCode => "adyenjs_0_1_18$MT6ppy0FAMVMLH..."
  },
  :returnUrl => "https://your-company.com/checkout/",
  :merchantAccount => "YourMerchantAccount"
})
```

### Change API Version
```ruby
adyen.checkout.version = 67
```

## List of supported methods

**checkout:**
- payment_session
- payments.result
- payment_methods
- payment_methods.balance
- payments
- payments.details
- payment_links
- payment_links.get
- payment_links.update
- origin_keys
- orders
- orders.cancel

**payments:**
- authorise
- authorise3d
- authorise3ds2
- get_authentication_result
- retrieve_3ds2_result

**modifications:**
- capture
- cancel
- refund
- cancel_or_refund
- technical_cancel
- adjust_authorisation
- donate
- void_pending_refund

**payouts:**
- confirm_third_party
- decline_third_party
- store_detail
- submit_third_party
- store_detail_and_submit_third_party
- payout

**recurring:**
- list_recurring_details
- disable
- store_token
- schedule_account_updater

**marketpay.account:**
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
- delete_payout_methods
- delete_shareholders
- check_account_holder

**marketpay.fund:**
- account_holder_balance
- account_holder_transaction_list
- payout_account_holder
- transfer_funds
- setup_beneficiary
- refund_not_paid_out_transfers

**marketpay.notification:**
- create_notification_configuration
- get_notification_configuration
- get_notification_configuration_list
- test_notification_configuration
- update_notification_configuration
- delete_notification_configurations

**marketpay.hop:**
- get_onboarding_url

**postfmapi:**
- assign_terminals
- find_terminal
- get_terminals_under_account

**data_protection:**
- request_subject_erasure

**dispute:**
- retrieve_applicable_defense_reasons
- supply_defense_document
- delete_dispute_defense_document
- defend_dispute

**bin_lookup:**
- get_3ds_availability
- get_cost_estimate

## Support
If you have a feature request, or spotted a bug or a technical problem, create a GitHub issue. For other questions, contact our [support team](https://support.adyen.com/hc/en-us/requests/new?ticket_form_id=360000705420).

## Contributing
We strongly encourage you to join us in contributing to this repository so everyone can benefit from:
* New features and functionality
* Resolved bug fixes and issues
* Any general improvements

Read our [**contribution guidelines**](CONTRIBUTING.md) to find out how.

## Licence

MIT license. For more information, see the LICENSE file.
