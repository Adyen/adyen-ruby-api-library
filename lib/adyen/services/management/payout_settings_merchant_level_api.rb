require_relative '../service'
module Adyen
  class PayoutSettingsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def delete_payout_setting(merchant_id, payout_settings_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings/{payoutSettingsId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payout_settings_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_payout_settings(merchant_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_payout_setting(merchant_id, payout_settings_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings/{payoutSettingsId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payout_settings_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_payout_setting(request, merchant_id, payout_settings_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings/{payoutSettingsId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, payout_settings_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def add_payout_setting(request, merchant_id, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
