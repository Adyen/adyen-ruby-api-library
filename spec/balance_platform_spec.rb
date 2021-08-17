require "spec_helper"

RSpec.describe Adyen::BalancePlatform, service: "Balance Platform service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:api_key)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["create_legal_entity", "id", "LE322KH223222D5DNL6HZ8RFV"],
  ]


  it "updates a legal entity" do
    legal_entity_id = "LE322KH223222D5DNL6HZ8RFV"
    request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/update_legal_entity.json"))

    response_body = json_from_file("mocks/responses/BalancePlatform/update_legal_entity.json")

    url = client.service_url("BalancePlatform", "legalEntities/#{legal_entity_id}", "1")
    WebMock.stub_request(:patch, url).
      with(
        body: request_body,
        headers: {
          "x-api-key" => client.api_key
        }
      ).
      to_return(
        body: response_body
      )

    result = client.balance_platform.update_legal_entity(request_body, legal_entity_id)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
  end

  it "gets a legal entity" do
    legal_entity_id = "LE322JV223222D5DNLR5C22TT"

    response_body = json_from_file("mocks/responses/BalancePlatform/get_legal_entity.json")

    url = client.service_url("BalancePlatform", "legalEntities/#{legal_entity_id}", "1")

    WebMock.stub_request(:get, url).
      with(
        headers: {
          "x-api-key" => client.api_key
        }
      ).
      to_return(
        body: response_body
      )

    result = client.balance_platform.get_legal_entity(legal_entity_id)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
  end

  generate_tests(client, "BalancePlatform", test_sets, client.balance_platform)
end

