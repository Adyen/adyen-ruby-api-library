require 'spec_helper'
require 'json'

RSpec.describe Adyen::TerminalCloudAPI, service: 'TerminalCloudAPI' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'TerminalCloudAPI'
    }
  end
  
  it 'makes a connectedTerminals POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/TerminalCloudAPI/connected_terminals.json'))

    response_body = json_from_file('mocks/responses/TerminalCloudAPI/connected_terminals.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'connectedTerminals', nil)
    WebMock.stub_request(:post, url)
           .with(
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: response_body
           )

    result = @shared_values[:client].terminal_cloud_api.connected_terminals(request_body)
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

  it 'makes a sync payment POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/TerminalCloudAPI/sync_payment.json'))

    response_body = json_from_file('mocks/responses/TerminalCloudAPI/sync_payment.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'sync', nil)
    WebMock.stub_request(:post, url)
           .with(
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: response_body
           )

    result = @shared_values[:client].terminal_cloud_api.sync(request_body)
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

  it 'makes an async payment POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/TerminalCloudAPI/sync_payment.json'))

    url = @shared_values[:client].service_url(@shared_values[:service], 'async', nil)
    WebMock.stub_request(:post, url)
           .with(
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: 'ok'
           )

    result = @shared_values[:client].terminal_cloud_api.async(request_body)
    response_hash = result.response

    expect(result.status)
      .to eq(200)
  end
end
# rubocop:enable Metrics/BlockLength
