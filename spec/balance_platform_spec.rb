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
    ["create_transfer_instrument", "id", "SE322JV223222D5DNVKPZ3GL7"],
    ["create_document", "id", "SE322JV223222D5DTMZBK44M5"],
    ["create_payment_instrument", "id", "PI3227C223222B5BPCMFXD2XG"]
  ]

  context "legal entities"do
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
  end

  context "account holders" do
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
  end


  context "balance accounts" do
    it "updates a balance account" do
      balance_account_id = "BA3227C223222B5DNV89TD83T"
      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/update_balance_account.json"))

      response_body = json_from_file("mocks/responses/BalancePlatform/update_balance_account.json")

      url = client.service_url("BalancePlatform", "balanceAccounts/#{balance_account_id}", "1")
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

      result = client.balance_platform.update_balance_account(request_body, balance_account_id)
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
  end

  context "paymentInstruments" do
    it "updates a payment instrument" do
      payment_instrument_id = "PI3227C223222B5BPCMFXD2XG"
      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/update_payment_instrument.json"))

      response_body = json_from_file("mocks/responses/BalancePlatform/update_payment_instrument.json")

      url = client.service_url("BalancePlatform", "paymentInstruments/#{payment_instrument_id}", "1")
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

      result = client.balance_platform.update_payment_instrument(request_body, payment_instrument_id)
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

    it "gets a payment instrument" do
      payment_instrument_id = "PI3227C223222B5BPCMFXD2XG"

      response_body = json_from_file("mocks/responses/BalancePlatform/get_payment_instrument.json")

      url = client.service_url("BalancePlatform", "paymentInstruments/#{payment_instrument_id}", "1")
      WebMock.stub_request(:get, url).
        with(
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: response_body
        )

      result = client.balance_platform.get_payment_instrument(payment_instrument_id)
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

  context "transferInstruments" do
    it "updates a transfer instrument" do
      transferInstrumentId = "SE322JV223222D5DNVKPZ3GL7"
      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/update_transfer_instrument.json"))

      response_body = json_from_file("mocks/responses/BalancePlatform/update_transfer_instrument.json")

      url = client.service_url("BalancePlatform", "transferInstruments/#{transferInstrumentId}", "1")
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

      result = client.balance_platform.update_transfer_instrument(request_body, transferInstrumentId)
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

    it "gets a transfer instrument" do
      transferInstrumentId = "SE322JV223222D5DNVKPZ3GL7"

      response_body = json_from_file("mocks/responses/BalancePlatform/get_transfer_instrument.json")

      url = client.service_url("BalancePlatform", "transferInstruments/#{transferInstrumentId}", "1")
      WebMock.stub_request(:get, url).
        with(
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: response_body
        )

      result = client.balance_platform.get_transfer_instrument(transferInstrumentId)
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

    it "deletes a transfer instrument" do
      transferInstrumentId = "SE322JV223222D5DNVKPZ3GL7"

      url = client.service_url("BalancePlatform", "transferInstruments/#{transferInstrumentId}", "1")
      WebMock.stub_request(:delete, url).
        with(
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: "",
          status: 204
        )

      result = client.balance_platform.delete_transfer_instrument(transferInstrumentId)
      response_hash = result.response

      expect(result.status).
        to eq(204)
      expect(response_hash).
        to eq("")
    end
  end

  context "documents" do
    it "updates a documents" do
      documentId = "SE322JV223222D5DTMZBK44M5"
      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/update_document.json"))

      response_body = json_from_file("mocks/responses/BalancePlatform/update_document.json")

      url = client.service_url("BalancePlatform", "documents/#{documentId}", "1")
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

      result = client.balance_platform.update_document(request_body, documentId)
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

    it "gets a document" do
      documentId = "SE322JV223222D5DTMZBK44M5"

      response_body = json_from_file("mocks/responses/BalancePlatform/get_document.json")

      url = client.service_url("BalancePlatform", "documents/#{documentId}", "1")
      WebMock.stub_request(:get, url).
        with(
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: response_body
        )

      result = client.balance_platform.get_document(documentId)
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

    it "deletes a document" do
      documentId = "SE322JV223222D5DTMZBK44M5"

      url = client.service_url("BalancePlatform", "documents/#{documentId}", "1")
      WebMock.stub_request(:delete, url).
        with(
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: "",
          status: 204
        )

      result = client.balance_platform.delete_document(documentId)
      response_hash = result.response

      expect(result.status).
        to eq(204)
      expect(response_hash).
        to eq("")
    end
  end

  context "publicKey" do
    it "gets a public key" do
      response_body = json_from_file("mocks/responses/BalancePlatform/get_public_key.json")

      url = client.service_url("BalancePlatform", "publicKey?purpose=pinReveal", "1")
      WebMock.stub_request(:get, url).
        with(
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: response_body
        )

      result = client.balance_platform.get_public_key("pinReveal")
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

  context "pin reveal" do
    it "retrieves the encrypted pin" do
      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/pin_reveal.json"))
      response_body = json_from_file("mocks/responses/BalancePlatform/pin_reveal.json")

      url = client.service_url("BalancePlatform", "pins/reveal", "1")
      WebMock.stub_request(:post, url).
        with(
          body: request_body,
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: response_body
        )

      result = client.balance_platform.get_payment_instrument_pin(request_body)
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

  context "payment instrument reveal" do
    it "retrieves the encrypted payment instrument data" do
      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/payment_instrument_reveal.json"))
      response_body = json_from_file("mocks/responses/BalancePlatform/payment_instrument_reveal.json")

      url = client.service_url("BalancePlatform", "paymentInstruments/reveal", "1")
      WebMock.stub_request(:post, url).
        with(
          body: request_body,
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: response_body
        )

      result = client.balance_platform.get_payment_instrument_information(request_body)
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

  generate_tests(client, "BalancePlatform", test_sets, client.balance_platform)
end
