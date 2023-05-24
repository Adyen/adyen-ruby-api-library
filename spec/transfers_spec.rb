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
end
# rubocop:enable Metrics/BlockLength
