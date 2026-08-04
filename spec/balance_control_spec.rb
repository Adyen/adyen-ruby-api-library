require 'spec_helper'
require 'json'

RSpec.describe Adyen::BalanceControl, service: 'balanceControl' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'BalanceControl'
    }
  end

  # must be created manually because every field in the response is an array
  it 'makes a balance transfer POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalanceControl/balance_transfer.json'))

    response_body = json_from_file('mocks/responses/BalanceControl/balance_transfer.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service], 
      'balanceTransfer',
      @shared_values[:client].balance_control.version)
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

    result = @shared_values[:client].balance_control.balance_control_api.balance_transfer(request_body)
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

  describe 'deprecated balance_transfer' do
    around do |example|
      previous = Warning[:deprecated]
      Warning[:deprecated] = true
      example.run
    ensure
      Warning[:deprecated] = previous
    end

    it 'emits a deprecation warning and still returns a successful response' do
      request_body = JSON.parse(json_from_file('mocks/requests/BalanceControl/balance_transfer.json'))

      response_body = json_from_file('mocks/responses/BalanceControl/balance_transfer.json')

      url = @shared_values[:client].service_url(
        @shared_values[:service],
        'balanceTransfer',
        @shared_values[:client].balance_control.version)
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

      result = nil
      expect do
        result = @shared_values[:client].balance_control.balance_control_api.balance_transfer(request_body)
      end.to output(/\[DEPRECATED\] `balance_transfer` is deprecated since Adyen Balance Control API v1\n/).to_stderr

      expect(result.status)
        .to eq(200)
      expect(result.response)
        .to eq(JSON.parse(response_body))
    end
  end
end
