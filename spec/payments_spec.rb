require 'spec_helper'
require 'json'

RSpec.describe Adyen::Payment, service: 'Payment' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'Payment'
    }
  end

  # must be created manually because every field in the response is an array
  it 'makes an adjust_authorisation POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/Payment/adjust_authorisation.json'))

    response_body = json_from_file('mocks/responses/Payment/adjust_authorisation.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'adjustAuthorisation',
                                              @shared_values[:client].payment.version)
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

    result = @shared_values[:client].payment.modifications_api.adjust_authorisation(request_body)
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
