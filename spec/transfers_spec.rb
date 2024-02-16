require 'spec_helper'
require 'json'

RSpec.describe Adyen::Transfers, service: 'transfers' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'Transfers'
    }
  end

  it 'makes a transfers POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/Transfers/make_transfer.json'))

    response_body = json_from_file('mocks/responses/Transfers/make_transfer.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'transfers',
                                              @shared_values[:client].transfers.version)
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

    result = @shared_values[:client].transfers.transfers_api.transfer_funds(request_body)

    expect(result.status)
      .to eq(200)
  end

  it 'makes a transactions GET call' do
    response_body = json_from_file('mocks/responses/Transfers/make_transfer.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'transactions?createdUntil=2021-05-30T15%3A07%3A40Z&createdSince=2021-05-30T15%3A07%3A40Z',
      @shared_values[:client].transfers.version
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

    result = @shared_values[:client].transfers.transactions_api.get_all_transactions(
      query_params: {
        'createdUntil' => '2021-05-30T15:07:40Z', 'createdSince' => '2021-05-30T15:07:40Z'
      }
    )

    expect(result.status)
      .to eq(200)
  end

  it "returns an error response including the headers" do
    authenticate_header = "abc"
    request_body = JSON.parse(json_from_file("mocks/requests/Transfers/make_transfer.json"))
    response_body = json_from_file("mocks/responses/Transfers/create_transfer_request_requires_sca.json")

    url = @shared_values[:client].service_url("Transfers", "transfers", "4")

    WebMock.stub_request(:post, url).
      with(
        headers: {
          "x-api-key" => @shared_values[:client].api_key,
          "WWW-Authenticate" => authenticate_header
        }
      ).
      to_return(
        status: 401,
        headers: {
          "WWW-Authenticate" => 'SCA realm="Transfer" auth-param1="1234"'
        },
        body: response_body
      )
  
      result = @shared_values[:client].transfers.transfers_api.transfer_funds(request_body, headers: {
        "WWW-Authenticate" => authenticate_header
      })
  
      expect(result.status).
        to eq(401)
      expect(result.response).
        to eq(JSON.parse(response_body))
      expect(result.response).
        to be_a Adyen::HashWithAccessors
      expect(result.header)
        .to eq({
          "www-authenticate" => 'SCA realm="Transfer" auth-param1="1234"'
        })
      expect(result.response).
        to be_a_kind_of Hash
    end
end
# rubocop:enable Metrics/BlockLength
