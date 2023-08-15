require_relative '../service'
module Adyen
  class WebhooksCompanyLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def remove_webhook(company_id, webhook_id, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id, webhook_id)
      
      action = { method: 'delete', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def list_all_webhooks(company_id, headers: {}, query_params: {})
      endpoint = '/companies/{companyId}/webhooks'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_webhook(company_id, webhook_id, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id, webhook_id)
      
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_webhook(request, company_id, webhook_id, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id, webhook_id)
      
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def set_up_webhook(request, company_id, headers: {})
      endpoint = '/companies/{companyId}/webhooks'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def generate_hmac_key(company_id, webhook_id, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}/generateHmac'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id, webhook_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def test_webhook(request, company_id, webhook_id, headers: {})
      endpoint = '/companies/{companyId}/webhooks/{webhookId}/test'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, company_id, webhook_id)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
