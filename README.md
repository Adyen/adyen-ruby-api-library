# Adyen API Library for Ruby


This is the officially supported Ruby library for using Adyen's APIs.

## Integration
The library supports all APIs under the following services:

* [Checkout API](https://docs.adyen.com/api-explorer/#/CheckoutService/v68/overview): Our latest integration for accepting online payments. Current supported version: **v68**
* [Payments API](https://docs.adyen.com/api-explorer/#/Payment/v64/overview): Our classic integration for online payments. Current supported version: **v64**
* [Recurring API](https://docs.adyen.com/api-explorer/#/Recurring/v49/overview): Endpoints for managing saved payment details. Current supported version: **v49**
* [Payouts API](https://docs.adyen.com/api-explorer/#/Payout/v64/overview): Endpoints for sending funds to your customers. Current supported version: **v64**
* [Platforms APIs](https://docs.adyen.com/platforms/api): Set of APIs when using Adyen for Platforms. 
  * [Account API](https://docs.adyen.com/api-explorer/#/Account/v6/overview) Current supported version: **v6**
  * [Fund API](https://docs.adyen.com/api-explorer/#/Fund/v6/overview) Current supported version: **v6**
  * [Notification Configuration API](https://docs.adyen.com/api-explorer/#/NotificationConfigurationService/v6/overview) Current supported version: **v6**
* [POS Terminal Management API](https://docs.adyen.com/api-explorer/#/postfmapi/v1/overview): Current supported version: **v1**
* [Adyen BinLookup API](https://docs.adyen.com/api-explorer/#/BinLookup/v50/overview): Current supported version: **v50**
* [Data Protection API](https://docs.adyen.com/development-resources/data-protection-api): Current supported version: **v1**
* [Disputes API](https://docs.adyen.com/risk-management/disputes-api): Current supported version: **v50**


For more information, refer to our [documentation](https://docs.adyen.com/) or the [API Explorer](https://docs.adyen.com/api-explorer/).

## Prerequisites
- [Adyen test account](https://docs.adyen.com/get-started-with-adyen)
- [API key](https://docs.adyen.com/development-resources/api-credentials#generate-api-key). For testing, your API credential needs to have the [API PCI Payments role](https://docs.adyen.com/development-resources/api-credentials#roles).
- Ruby >= 2.1

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
response = adyen.checkout.payments({
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
