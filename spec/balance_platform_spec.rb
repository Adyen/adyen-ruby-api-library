require "spec_helper"

RSpec.describe Adyen::BalancePlatform, service: "Balance Platform service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:api_key)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["create_legal_entity", "id", "LE322KH223222D5DNL6HZ8RFV"],
    ["create_account_holder", "id", "AH3227C223222B5DNPXZM93VQ"],
    ["create_balance_account", "id", "BA3227C223222B5DNV89TD83T"],
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

  it "updates an account holder" do
    account_holder_id = "AH3227C223222B5DNPXZM93VQ"
    request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/update_account_holder.json"))

    response_body = json_from_file("mocks/responses/BalancePlatform/update_account_holder.json")

    url = client.service_url("BalancePlatform", "accountHolders/#{account_holder_id}", "1")
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

    result = client.balance_platform.update_account_holder(request_body, account_holder_id)
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

  it "gets an account holder" do
    account_holder_id = "AH3227C223222B5DNPXZM93VQ"

    response_body = json_from_file("mocks/responses/BalancePlatform/get_account_holder.json")

    url = client.service_url("BalancePlatform", "accountHolders/#{account_holder_id}", "1")
    WebMock.stub_request(:get, url).
      with(
        headers: {
          "x-api-key" => client.api_key
        }
      ).
      to_return(
        body: response_body
      )

    result = client.balance_platform.get_account_holder(account_holder_id)
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

  it "gets a balance account" do
    balance_account_id = "BA3227C223222B5DNV89TD83T"

    response_body = json_from_file("mocks/responses/BalancePlatform/get_balance_account.json")

    url = client.service_url("BalancePlatform", "balanceAccounts/#{balance_account_id}", "1")
    WebMock.stub_request(:get, url).
      with(
        headers: {
          "x-api-key" => client.api_key
        }
      ).
      to_return(
        body: response_body
      )

    result = client.balance_platform.get_balance_account(balance_account_id)
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

