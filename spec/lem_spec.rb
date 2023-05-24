require 'spec_helper'
require 'json'

RSpec.describe Adyen::LegalEntityManagement, service: 'LegalEntityManagement' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'LegalEntityManagement'
    }
  end

  # must be created manually because every field in the response is an array
  it 'makes a business_lines POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/LegalEntityManagement/create_business_line.json'))

    response_body = json_from_file('mocks/responses/LegalEntityManagement/create_business_line.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'businessLines',
                                              @shared_values[:client].legal_entity_management.version)
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

    result = @shared_values[:client].legal_entity_management.business_lines_api.create_business_line(request_body)
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

  it 'makes a documents DELETE call' do
    url = @shared_values[:client].service_url(@shared_values[:service], 'documents/123',
                                              @shared_values[:client].legal_entity_management.version)
    WebMock.stub_request(:delete, url)
           .with(
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: '{}'
           )

    result = @shared_values[:client].legal_entity_management.documents_api.delete_document('123')
    result.response

    expect(result.status)
      .to eq(200)
  end
end
