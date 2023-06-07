![Ruby](https://user-images.githubusercontent.com/93914435/236416787-3da4dd32-0a7d-43f7-9aa4-8d77697c85f9.png)
# Adyen API Library for Ruby

This is the officially supported Ruby library for using Adyen's APIs.

## Supported APIs

This library supports the following:

| API name | API version | Description | API object |
|----------|:-----------:|-------------|------------|
| [BIN lookup API](https://docs.adyen.com/api-explorer/BinLookup/54/overview) | v54 | The BIN Lookup API provides endpoints for retrieving information based on a given BIN. | [BinLookup](lib/adyen/services/binLookup.rb) |
| [Checkout API](https://docs.adyen.com/api-explorer/Checkout/70/overview) | v70 | Our latest integration for accepting online payments. | [CheckoutAPI](lib/adyen/services/checkout.rb) |
| [Configuration API](https://docs.adyen.com/api-explorer/balanceplatform/2/overview) | v2 | The Configuration API enables you to create a platform where you can onboard your users as account holders and create balance accounts, cards, and business accounts. | [BalancePlatform](lib/adyen/services/balancePlatform.rb) |
| [DataProtection API](https://docs.adyen.com/development-resources/data-protection-api) | v1 | Adyen Data Protection API provides a way for you to process [Subject Erasure Requests](https://gdpr-info.eu/art-17-gdpr/) as mandated in GDPR. Use our API to submit a request to delete shopper's data, including payment details and other related information (for example, delivery address or shopper email) | [DataProtection](lib/adyen/services/dataProtection.rb) |
| [Legal Entity Management API](https://docs.adyen.com/api-explorer/legalentity/3/overview) | v3 | Manage legal entities that contain information required for verification. | [LegalEntityManagement](lib/adyen/services/legalEntityManagement.rb) |
| [Management API](https://docs.adyen.com/api-explorer/Management/1/overview) | v1 | Configure and manage your Adyen company and merchant accounts, stores, and payment terminals. | [Management](lib/adyen/services/management.rb) |
| [Payments API](https://docs.adyen.com/api-explorer/Payment/68/overview) | v68 | Our classic integration for online payments. | [Classic Integration API](lib/adyen/services/payment.rb) |
| [Payouts API](https://docs.adyen.com/api-explorer/Payout/68/overview) | v68 | Endpoints for sending funds to your customers. | [Payout](lib/adyen/services/payout.rb) |
| [POS Terminal Management API](https://docs.adyen.com/api-explorer/postfmapi/1/overview) | v1 | Endpoints for managing your point-of-sale payment terminals. | [TerminalManagement](lib/adyen/services/posTerminalManagement.rb) |
| [Recurring API](https://docs.adyen.com/api-explorer/Recurring/68/overview) | v68 | Endpoints for managing saved payment details. | [Recurring](lib/adyen/services/recurring.rb) |
| [Stored Value API](https://docs.adyen.com/payment-methods/gift-cards/stored-value-api) | v46 | Manage both online and point-of-sale gift cards and other stored-value cards. | [StoredValue](lib/adyen/services/storedValue.rb) |
| [Transfers API](https://docs.adyen.com/api-explorer/transfers/3/overview) | v3 | The Transfers API provides endpoints that can be used to get information about all your transactions, move funds within your balance platform or send funds from your balance platform to a transfer instrument. | [Transfers](lib/adyen/services/transfers.rb) |

For more information, refer to our [documentation](https://docs.adyen.com/) or the [API Explorer](https://docs.adyen.com/api-explorer/).

## Prerequisites
- [Adyen test account](https://docs.adyen.com/get-started-with-adyen)
- [API key](https://docs.adyen.com/development-resources/api-credentials#generate-api-key). For testing, your API credential needs to have the [API PCI Payments role](https://docs.adyen.com/development-resources/api-credentials#roles).
- Ruby >= 2.7

## Installation

The sole dependency is faraday for HTTP communication.  Run the following command to install faraday if you don't already have it:

~~~~bash 
bundle install
~~~~

To validate functionality of client and run mock API tests use

~~~~bash  
bundle install --with development 
~~~~
and
~~~~bash 
rspec
~~~~
## Documentation

Follow the rest of our guides from the [documentation](https://adyen.github.io/adyen-ruby-api-library/) on how to use this library.

## Using the library

### General use with API key

~~~~bash 
require 'adyen-ruby-api-library'
~~~~
~~~~ruby
adyen = Adyen::Client.new

adyen.api_key = 'AF5XXXXXXXXXXXXXXXXXXXX'

~~~~

- Make a Payment
~~~~ruby
response = adyen.checkout.payments_api.payments({
  :amount => {
    :currency => "EUR",
    :value => 1000
  },
  :reference => "Your order number",
  :paymentMethod => {
    :type => "scheme",
    :encryptedCardNumber => "test_4111111111111111",
    :encryptedExpiryMonth => "test_03",
    :encryptedExpiryYear => "test_2030",
    :encryptedSecurityCode => "test_737"
  },
  :returnUrl => "https://your-company.com/checkout/",
  :merchantAccount => "YourMerchantAccount"
})
~~~~

- Change API Version
~~~~ruby
adyen.checkout.version = 68
~~~~

### Example integration

For a closer look at how our Ruby library works, clone our [example integration](https://github.com/adyen-examples/adyen-rails-online-payments). This includes commented code, highlighting key features and concepts, and examples of API calls that can be made using the library.

### Running the tests
To run the tests use : 
~~~~bash  
bundle install --with development 
~~~~

## Feedback
We value your input! Help us enhance our API Libraries and improve the integration experience by providing your feedback. Please take a moment to fill out [our feedback form](https://forms.gle/A4EERrR6CWgKWe5r9) to share your thoughts, suggestions or ideas.

## Contributing

We encourage you to contribute to this repository, so everyone can benefit from new features, bug fixes, and any other improvements.
Have a look at our [contributing guidelines](https://github.com/Adyen/adyen-ruby-api-library/blob/develop/CONTRIBUTING.md) to find out how to raise a pull request.

## Support
If you have a feature request, or spotted a bug or a technical problem, [create an issue here](https://github.com/Adyen/adyen-ruby-api-library/issues/new/choose).

For other questions, [contact our Support Team](https://www.adyen.help/hc/en-us/requests/new?ticket_form_id=360000705420).

## Licence
This repository is available under the [MIT license](https://github.com/Adyen/adyen-ruby-api-library/blob/main/LICENSE).

## See also
* [Example integration](https://github.com/adyen-examples/adyen-rails-online-payments)
* [Adyen docs](https://docs.adyen.com/)
* [API Explorer](https://docs.adyen.com/api-explorer/)
