# frozen_string_literal: true

require_relative '../service'
module Adyen
  class HostedOnboardingApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = 'LegalEntityManagement'
      @client = client
      @version = version
    end

    def list_hosted_onboarding_page_themes(headers: {})
      endpoint = '/themes'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)

      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_onboarding_link_theme(id, headers: {})
      endpoint = '/themes/{id}'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)

      action = { method: 'get', url: endpoint }
      @client.call_adyen_api(@service, action, {}, headers, @version)
    end

    def get_link_to_adyenhosted_onboarding_page(request, id, headers: {})
      endpoint = '/legalEntities/{id}/onboardingLinks'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint, id)

      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end
  end
end
