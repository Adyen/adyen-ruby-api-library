require 'spec_helper'
require 'json'

RSpec.describe Adyen::SessionAuthentication, service: 'SessionAuthentication' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'SessionAuthentication'
    }
  end

  it 'makes a create_authentication_session POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/SessionAuthentication/create_authentication_session.json'))
    response_body = json_from_file('mocks/responses/SessionAuthentication/create_authentication_session.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'sessions',
      @shared_values[:client].session_authentication.version
    )
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

    result = @shared_values[:client].session_authentication.session_authentication_api.create_authentication_session(request_body)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end
end
