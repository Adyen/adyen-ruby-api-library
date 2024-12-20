require_relative '../service'
module Adyen

  # NOTE: This class is auto generated by OpenAPI Generator
  # Ref: https://openapi-generator.tech
  #
  # Do not edit the class manually.
  class PayoutSettingsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    # Add a payout setting
    def add_payout_setting(request, merchant_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    # Delete a payout setting
    def delete_payout_setting(merchant_id, payout_settings_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings/{payoutSettingsId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payout_settings_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get a payout setting
    def get_payout_setting(merchant_id, payout_settings_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings/{payoutSettingsId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payout_settings_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Get a list of payout settings
    def list_payout_settings(merchant_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    # Update a payout setting
    def update_payout_setting(request, merchant_id, payout_settings_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings/{payoutSettingsId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payout_settings_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
