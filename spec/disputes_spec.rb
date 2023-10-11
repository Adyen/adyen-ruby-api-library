require 'spec_helper'

RSpec.describe Adyen::Disputes, service: 'disputes service' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'Disputes'
    }
  end

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ['accept_dispute', 'disputeServiceResult', { 'success' => true }],
    ['supply_defense_document', 'disputeServiceResult', { 'success' => true }],
    ['delete_dispute_defense_document', 'disputeServiceResult', { 'success' => true }],
    ['defend_dispute', 'disputeServiceResult', { 'success' => true }]
  ]

  generate_tests(client, 'DisputesService', test_sets, client.disputes)

  it 'makes a retrieve_applicable_defense_reasons call' do
    request_body = JSON.parse(json_from_file('mocks/requests/Disputes/retrieve_applicable_defense_reasons.json'))

    response_body = json_from_file('mocks/responses/Disputes/retrieve_applicable_defense_reasons.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'retrieveApplicableDefenseReasons',
                                              @shared_values[:client].disputes.version)
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

    result = @shared_values[:client].disputes.retrieve_applicable_defense_reasons(request_body)
    response_hash = result.response

    expect(result.status)
      .to eq(200)
    expect(response_hash)
      .to eq(JSON.parse(response_body))
    expect(response_hash)
      .to be_a Adyen::HashWithAccessors
    expect(response_hash)
      .to be_a_kind_of Hash
    expect(response_hash['disputeServiceResult']['success'])
      .to eq('true')
  end
end
