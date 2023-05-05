require_relative '../service'
module Adyen


  class PayoutSettingsMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "Management"
      @client = client
      @version = version
    end

    def delete_payout_setting(merchantId, payoutSettingsId, headers: {} )
      """
      Delete a payout setting
      """
      endpoint = "/merchants/{merchantId}/payoutSettings/{payoutSettingsId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,payoutSettingsId]
      
      action = { method: "delete", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_payout_settings(merchantId, headers: {} )
      """
      Get a list of payout settings
      """
      endpoint = "/merchants/{merchantId}/payoutSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_payout_setting(merchantId, payoutSettingsId, headers: {} )
      """
      Get a payout setting
      """
      endpoint = "/merchants/{merchantId}/payoutSettings/{payoutSettingsId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,payoutSettingsId]
      
      action = { method: "get", url: endpoint}
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_payout_setting(request, merchantId, payoutSettingsId, headers: {} )
      """
      Update a payout setting
      """
      endpoint = "/merchants/{merchantId}/payoutSettings/{payoutSettingsId}".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId,payoutSettingsId]
      
      action = { method: "patch", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def add_payout_setting(request, merchantId, headers: {} )
      """
      Add a payout setting
      """
      endpoint = "/merchants/{merchantId}/payoutSettings".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % [merchantId]
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
