require_relative '../service'
module Adyen

  # NOTE: This class is auto generated by OpenAPI Generator
  # Ref: https://openapi-generator.tech
  #
  # Do not edit the class manually.
  class AuthorizedCardUsersApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'BalancePlatform')
    end

    # Create authorized users for a card.
    def create_authorised_card_users(request, payment_instrument_id, authorised_card_users, headers: {})
      endpoint = '/paymentInstruments/{paymentInstrumentId}/authorisedCardUsers'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, payment_instrument_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Delete the authorized users for a card.
    def delete_authorised_card_users(payment_instrument_id, headers: {})
      endpoint = '/paymentInstruments/{paymentInstrumentId}/authorisedCardUsers'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, payment_instrument_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get authorized users for a card.
    def get_all_authorised_card_users(payment_instrument_id, headers: {})
      endpoint = '/paymentInstruments/{paymentInstrumentId}/authorisedCardUsers'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, payment_instrument_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Update the authorized users for a card.
    def update_authorised_card_users(request, payment_instrument_id, authorised_card_users, headers: {})
      endpoint = '/paymentInstruments/{paymentInstrumentId}/authorisedCardUsers'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, payment_instrument_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
