require_relative '../service'
module Adyen
  class SplitConfigurationMerchantLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def delete_split_configuration(merchant_id, split_configuration_id, headers: {})
      endpoint = '/merchants/{merchantId}/splitConfigurations/{splitConfigurationId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, split_configuration_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def delete_split_configuration_rule(merchant_id, split_configuration_id, rule_id, headers: {})
      endpoint = '/merchants/{merchantId}/splitConfigurations/{splitConfigurationId}/rules/{ruleId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, split_configuration_id, rule_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_split_configurations(merchant_id, headers: {})
      endpoint = '/merchants/{merchantId}/splitConfigurations'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_split_configuration(merchant_id, split_configuration_id, headers: {})
      endpoint = '/merchants/{merchantId}/splitConfigurations/{splitConfigurationId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, split_configuration_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_split_configuration_description(request, merchant_id, split_configuration_id, headers: {})
      endpoint = '/merchants/{merchantId}/splitConfigurations/{splitConfigurationId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, split_configuration_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_split_conditions(request, merchant_id, split_configuration_id, rule_id, headers: {})
      endpoint = '/merchants/{merchantId}/splitConfigurations/{splitConfigurationId}/rules/{ruleId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, split_configuration_id, rule_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_split_logic(request, merchant_id, split_configuration_id, rule_id, split_logic_id, headers: {})
      endpoint = '/merchants/{merchantId}/splitConfigurations/{splitConfigurationId}/rules/{ruleId}/splitLogic/{splitLogicId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, split_configuration_id, rule_id, split_logic_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_split_configuration(request, merchant_id, headers: {})
      endpoint = '/merchants/{merchantId}/splitConfigurations'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def create_rule(request, merchant_id, split_configuration_id, headers: {})
      endpoint = '/merchants/{merchantId}/splitConfigurations/{splitConfigurationId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, split_configuration_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
