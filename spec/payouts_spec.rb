require 'spec_helper'
require 'json'

RSpec.describe Adyen::Payout, service: 'Payout' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'Payout'
    }
  end

  # must be created manually because every field in the response is an array
  it 'makes a business_lines POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/Payout/confirm_third_party.json'))

    response_body = json_from_file('mocks/responses/Payout/confirm_third_party.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'confirmThirdParty',
                                              @shared_values[:client].payout.version)
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

    result = @shared_values[:client].payout.reviewing_api.confirm_third_party(request_body)
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
