require 'spec_helper'
require 'json'

RSpec.describe Adyen::OpenBanking, service: 'OpenBanking' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'OpenBanking'
    }
  end

  it 'makes a create_account_verification_routes POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/OpenBanking/create_account_verification_routes.json'))
    response_body = json_from_file('mocks/responses/OpenBanking/create_account_verification_routes.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'accountVerification/routes',
      @shared_values[:client].open_banking.version
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

    result = @shared_values[:client].open_banking.account_verification_api.create_account_verification_routes(request_body)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_account_verification_report GET call' do
    response_body = json_from_file('mocks/responses/OpenBanking/get_account_verification_report.json')
    code = 'some-verification-code'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "accountVerification/reports/#{code}",
      @shared_values[:client].open_banking.version
    )
    WebMock.stub_request(:get, url)
           .with(
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: response_body
           )

    result = @shared_values[:client].open_banking.account_verification_api.get_account_verification_report(code)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end
end