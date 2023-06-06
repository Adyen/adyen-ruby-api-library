require_relative '../service'
module Adyen
  class TerminalSettingsStoreLevelApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Management')
    end

    def get_terminal_logo(merchant_id, reference, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/stores/{reference}/terminalLogos'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, reference)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_settings(merchant_id, reference, headers: {})
      endpoint = '/merchants/{merchantId}/stores/{reference}/terminalSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, reference)

      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_logo_by_store_id(store_id, headers: {}, query_params: {})
      endpoint = '/stores/{storeId}/terminalLogos'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, store_id)
      endpoint += create_query_string(query_params)
      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_terminal_settings_by_store_id(store_id, headers: {})
      endpoint = '/stores/{storeId}/terminalSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, store_id)

      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def update_terminal_logo(request, merchant_id, reference, headers: {}, query_params: {})
      endpoint = '/merchants/{merchantId}/stores/{reference}/terminalLogos'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, reference)
      endpoint += create_query_string(query_params)
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_settings(request, merchant_id, reference, headers: {})
      endpoint = '/merchants/{merchantId}/stores/{reference}/terminalSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, merchant_id, reference)

      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_logo_by_store_id(request, store_id, headers: {}, query_params: {})
      endpoint = '/stores/{storeId}/terminalLogos'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, store_id)
      endpoint += create_query_string(query_params)
      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def update_terminal_settings_by_store_id(request, store_id, headers: {})
      endpoint = '/stores/{storeId}/terminalSettings'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, store_id)

      action = { method: 'patch', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
