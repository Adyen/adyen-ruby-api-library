require_relative '../service'
module Adyen
  class PayoutSettingsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def delete_payout_setting(merchantId, payoutSettingsId, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings/{payoutSettingsId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdpayoutSettingsId)
      
      action = { method: "delete", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_payout_settings(merchantId, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_payout_setting(merchantId, payoutSettingsId, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings/{payoutSettingsId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdpayoutSettingsId)
      
      action = { method: "get", url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_payout_setting(request, merchantId, payoutSettingsId, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings/{payoutSettingsId}'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantIdpayoutSettingsId)
      
      action = { method: "patch", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def add_payout_setting(request, merchantId, headers: {})
      endpoint = '/merchants/{merchantId}/payoutSettings'.gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpointmerchantId)
      
      action = { method: "post", url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
