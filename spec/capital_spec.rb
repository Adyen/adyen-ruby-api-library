require 'spec_helper'
require 'json'

RSpec.describe Adyen::Capital do
  let(:client) { create_client(:api_key) }
  let(:service) { 'Capital' }
  let(:version) { client.capital.version }

  describe 'GrantAccountsApi' do
    it 'gets grant account information' do
      response_body = json_from_file('mocks/responses/Capital/get-grant-account-success.json')
      grant_account_id = 'CG00000000000000000000001'

      url = client.service_url(service, "grantAccounts/#{grant_account_id}", version)

      WebMock.stub_request(:get, url)
             .with(headers: { 'x-api-key' => client.api_key })
             .to_return(body: response_body)

      result = client.capital.grant_accounts_api.get_grant_account_information(grant_account_id)

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
      expect(result.response).to be_a(Adyen::HashWithAccessors)
      expect(result.response).to be_a(Hash)
    end
  end

  describe 'GrantOffersApi' do
    it 'gets all grant offers with query params' do
      response_body = json_from_file('mocks/responses/Capital/grant-offers-success.json')
      account_holder_id = 'AH00000000000000000000001'

      url = client.service_url(service, 'grantOffers', version)

      WebMock.stub_request(:get, url)
             .with(
               query: { 'accountHolderId' => account_holder_id },
               headers: { 'x-api-key' => client.api_key }
             )
             .to_return(body: response_body)

      result = client.capital.grant_offers_api.get_all_grant_offers(query_params: { 'accountHolderId' => account_holder_id })

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
    end

    it 'gets all grant offers without query params' do
      response_body = json_from_file('mocks/responses/Capital/grant-offers-success.json')

      url = client.service_url(service, 'grantOffers', version)

      WebMock.stub_request(:get, url)
             .with(headers: { 'x-api-key' => client.api_key })
             .to_return(body: response_body)

      result = client.capital.grant_offers_api.get_all_grant_offers

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
    end

    it 'gets a specific grant offer' do
      response_body = json_from_file('mocks/responses/Capital/get-grant-offer-success.json')
      id = 'GO00000000000000000000001'

      url = client.service_url(service, "grantOffers/#{id}", version)

      WebMock.stub_request(:get, url)
             .with(headers: { 'x-api-key' => client.api_key })
             .to_return(body: response_body)

      result = client.capital.grant_offers_api.get_grant_offer(id)

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
    end
  end

  describe 'GrantsApi' do
    it 'gets a specific grant' do
      response_body = json_from_file('mocks/responses/Capital/get-grant-success.json')
      id = 'GR00000000000000000000001'

      url = client.service_url(service, "grants/#{id}", version)

      WebMock.stub_request(:get, url)
             .with(headers: { 'x-api-key' => client.api_key })
             .to_return(body: response_body)

      result = client.capital.grants_api.get_grant(id)

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
    end

    it 'gets all grants' do
      response_body = json_from_file('mocks/responses/Capital/grants-success.json')

      url = client.service_url(service, 'grants', version)

      WebMock.stub_request(:get, url)
             .with(headers: { 'x-api-key' => client.api_key })
             .to_return(body: response_body)

      result = client.capital.grants_api.get_all_grants

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
    end

    it 'requests a grant' do
      request_payload = { "grantAccountId" => "GR00000000000000000000001" }
      response_body = json_from_file('mocks/responses/Capital/request-grant.json')

      url = client.service_url(service, 'grants', version)

      WebMock.stub_request(:post, url)
             .with(
               body: request_payload,
               headers: { 'x-api-key' => client.api_key }
             )
             .to_return(body: response_body)

      result = client.capital.grants_api.request_grant(request_payload)

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
    end

    it 'gets a grant disbursement' do
      response_body = json_from_file('mocks/responses/Capital/get-grant-disbursement-success.json')
      grant_id = 'GR00000000000000000000001'
      disbursement_id = 'DI00000000000000000000001'

      url = client.service_url(service, "grants/#{grant_id}/disbursements/#{disbursement_id}", version)

      WebMock.stub_request(:get, url)
             .with(headers: { 'x-api-key' => client.api_key })
             .to_return(body: response_body)

      result = client.capital.grants_api.get_grant_disbursement(grant_id, disbursement_id)

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
    end

    it 'gets all grant disbursements' do
      response_body = json_from_file('mocks/responses/Capital/get-grant-disbursements-success.json')
      grant_id = 'GR00000000000000000000001'

      url = client.service_url(service, "grants/#{grant_id}/disbursements", version)

      WebMock.stub_request(:get, url)
             .with(headers: { 'x-api-key' => client.api_key })
             .to_return(body: response_body)

      result = client.capital.grants_api.get_all_grant_disbursements(grant_id)

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
    end

    it 'updates a grant disbursement' do
      response_body = json_from_file('mocks/responses/Capital/update-grant-disbursement-success.json')
      grant_id = 'GR00000000000000000000001'
      disbursement_id = 'DI00000000000000000000001'
      request_payload = {}

      url = client.service_url(service, "grants/#{grant_id}/disbursements/#{disbursement_id}", version)

      WebMock.stub_request(:patch, url)
             .with(
               body: request_payload,
               headers: { 'x-api-key' => client.api_key }
             )
             .to_return(body: response_body)

      result = client.capital.grants_api.update_grant_disbursement(request_payload, grant_id, disbursement_id)

      expect(result.status).to eq(200)
      expect(result.response).to eq(JSON.parse(response_body))
    end
  end
end