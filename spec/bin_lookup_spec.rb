require 'spec_helper'
require 'json'

RSpec.describe Adyen::BinLookup, service: 'BinLookup' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'BinLookup'
    }
  end

  # must be created manually because every field in the response is an array
  it 'makes a get_cost_estimate POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BinLookup/get_cost_estimate.json'))

    response_body = json_from_file('mocks/responses/BinLookup/get_cost_estimate.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'getCostEstimate',
                                              @shared_values[:client].bin_lookup.version)
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

    result = @shared_values[:client].bin_lookup.get_cost_estimate(request_body)
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
  it 'makes a get3ds_availability POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BinLookup/get_3ds_availability.json'))

    response_body = json_from_file('mocks/responses/BinLookup/get_3ds_availability.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'get3dsAvailability',
                                              @shared_values[:client].bin_lookup.version)
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

    result = @shared_values[:client].bin_lookup.get3ds_availability(request_body)
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
end
