require_relative '../service'
module Adyen
  class DonationsApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      super(client, version, 'Checkout')
    end

    def donation_campaigns(request, headers: {})
      endpoint = '/donationCampaigns'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

    def donations(request, headers: {})
      endpoint = '/donations'.gsub(/{.+?}/, '%s')
      endpoint = endpoint.gsub(%r{^/}, '')
      endpoint = format(endpoint)
      
      action = { method: 'post', url: endpoint }
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
