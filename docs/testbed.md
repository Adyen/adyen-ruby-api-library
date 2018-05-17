##Available methods

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

##Overview

Use Adyen MarketPay to power your marketplace with onboarding, payment processing, and payouts.

Adyen MarketPay is an end-to-end payment solution for platforms and marketplaces. MarketPay's extensive API powers many types of platforms, such as crowdfunding platforms, peer-to-peer marketplaces, and on-demand services.

MarketPay enables you to onboard sellers, service providers or contractors as sub-merchants and accept payments on their behalf. You can also split payments, transfer funds, and pay out to sub-merchants.

Technically, MarketPay is broken down into 3 separate services:
- Account
- Fund
- Notification


##Authentication
MarketPay is authenticated via webservice username and password.

##Account

The Account service is used for onboarding and KYC for people on both sides of your marketplace.

To create an account holder, use the create_account_holder method:
```ruby
response = adyen.marketpay.account('{
   "accountHolderCode":"GENERATE_CODE", // Your unique ID
   "accountHolderDetails":{
      "email":"tim@green.com",
      "individualDetails":{
         "name":{
            "firstName":"Tim",
            "gender": "MALE",
            "lastName":"Green"
         }
      }
   },
   "legalEntity":"Individual"
}')
```

To enable payouts to an account, send required KYC information and docuemnts to the update_account_holder and upload_documents methods.  Required KYC can be found in our docs [here](https://docs.adyen.com/developers/marketpay/onboarding-and-verification#step2step2enablepayouts).

You can disable / delete account holders in the same way.

##Fund

The MarketPay Funding API provides endpoints for managing the funds in MarketPay accounts. These management operations include actions such as the transfer of funds from one account to another, the payout of funds to an account holder, and the retrieval of balances in an account.

For further information on MarketPay fund management, please visit the [MarketPay documentation](https://docs.adyen.com/developers/marketpay/marketpay-overview).

##Notification
The Adyen MarketPay system can send you notifications for a set of events during the flow, such as creating new accounts or account holders, performing KYC checks, making payouts, and so on. 

These notifications are sent as webhooks to the corresponding URLs configured on your server. Refer to the [Configure notifications](https://docs.adyen.com/developers/marketpay/marketpay-notifications/configure-notifications) section to learn how you can set up and test MarketPay notifications, and to [Receive notifications](Receive notifications) to explore notification types and see the examples.