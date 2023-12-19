require 'spec_helper'
require 'json'

RSpec.describe Adyen::Management, service: 'Management' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'Management'
    }
  end

  # must be created manually because every field in the response is an array
  it 'makes a companies GET call' do
    response_body = json_from_file('mocks/responses/Management/get_companies.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'companies',
                                              @shared_values[:client].management.version)
    WebMock.stub_request(:get, url)
           .with(
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: response_body
           )

    result = @shared_values[:client].management.account_company_level_api.list_company_accounts
    response_hash = result.response

    expect(result.status)
      .to eq(200)
    expect(response_hash)
      .to eq(JSON.parse(response_body))
    expect(response_hash)
      .to be_a Adyen::HashWithAccessors
    expect(response_hash)
      .to be_a_kind_of Hash
  end

  it 'makes a create_store POST call' do
    request_body = JSON.parse(json_from_file('mocks/responses/LegalEntityManagement/create_business_line.json'))

    response_body = json_from_file('mocks/responses/LegalEntityManagement/create_business_line.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'merchants/merchantID/stores',
                                              @shared_values[:client].management.version)
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: response_body
           )

    result = @shared_values[:client].management.account_store_level_api.create_store_by_merchant_id(request_body,
                                                                                                    'merchantID')
    result.response

    expect(result.status)
      .to eq(200)
  end
end
