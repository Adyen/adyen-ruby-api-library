require "spec_helper"

RSpec.describe Adyen::Transfers, service: "Balance Platform service" do
  client = create_client(:api_key)

  context "transaction" do
    it "retrieves transactions" do
      balance_account_id = "BA32272223222B5FD6CD2FNXB"
      response_body = json_from_file("mocks/responses/Transfers/get_transactions.json")
  
      url = client.service_url("Transfers", "transactions", "3")
  
      request_params = {
        "balanceAccountId" => balance_account_id,
        "createdSince" => "2021-01-01T15:07:40Z",
        "createdUntil" => "2022-12-31T15:07:40Z",
        "limit" => "100"
      }
  
      WebMock.stub_request(:get, url).
        with(
          headers: {
            "x-api-key" => client.api_key
          },
          query: request_params
        ).
        to_return(
          body: response_body
        )
  
      result = client.transfers.get_transactions(request_params)
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
  
    it "retrieves information about a single transaction" do
      transaction_id = "3JERI55U58GRGWCK"
      response_body = json_from_file("mocks/responses/Transfers/get_transaction.json")
  
      url = client.service_url("Transfers", "transactions/#{transaction_id}", "3")
  
      WebMock.stub_request(:get, url).
        with(
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: response_body
        )
  
      result = client.transfers.get_transaction(transaction_id)
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
  end
  
  context "transfers" do
    it "creates a transfer" do
      authenticate_header = "abc"
      request_body = JSON.parse(json_from_file("mocks/requests/Transfers/create_transfer_request.json"))
      response_body = json_from_file("mocks/responses/Transfers/create_transfer_request.json")
  
      url = client.service_url("Transfers", "transfers", "3")
  
      WebMock.stub_request(:post, url).
        with(
          headers: {
            "x-api-key" => client.api_key,
            "WWW-Authenticate" => authenticate_header
          }
        ).
        to_return(
          body: response_body
        )
  
      result = client.transfers.create_transfer_request(request_body, {
        "WWW-Authenticate" => authenticate_header
      })
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

    it "returns an error response including the headers" do
      authenticate_header = "abc"
      request_body = JSON.parse(json_from_file("mocks/requests/Transfers/create_transfer_request.json"))
      response_body = json_from_file("mocks/responses/Transfers/create_transfer_request_requires_sca.json")
  
      url = client.service_url("Transfers", "transfers", "3")
  
      WebMock.stub_request(:post, url).
        with(
          headers: {
            "x-api-key" => client.api_key,
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
  
      result = client.transfers.create_transfer_request(request_body, {
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
end
