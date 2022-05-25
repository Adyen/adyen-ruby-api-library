require "spec_helper"

RSpec.describe Adyen::LegalEntityManagement, service: "Legal entity management service" do
  # client instance to be used in dynamically generated tests
  client = create_client(:basic)

  # methods / values to test for
  # format is defined in spec_helper
  test_sets = [
    ["create_legal_entity", "id", "LE322KH223222D5DNL6HZ8RFV"],
    ["create_transfer_instrument", "id", "SE322JV223222D5DNVKPZ3GL7"],
    ["create_document", "id", "SE322JV223222D5DTMZBK44M5"],
    ["create_business_line", "id", "SE322JV223222D5FKLGQPC2H5"]
  ]

  context "legal entities"do
    it "updates a legal entity" do
      legal_entity_id = "LE322KH223222D5DNL6HZ8RFV"
      request_body = JSON.parse(json_from_file("mocks/requests/LegalEntityManagement/update_legal_entity.json"))

      response_body = json_from_file("mocks/responses/LegalEntityManagement/update_legal_entity.json")

      url = client.service_url("LegalEntityManagement", "legalEntities/#{legal_entity_id}", "1")

      WebMock.stub_request(:patch, url).
        with(
          body: request_body
        ).
        to_return(
          body: response_body
        )

      result = client.legal_entity_management.update_legal_entity(request_body, legal_entity_id)
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

      response_body = json_from_file("mocks/responses/LegalEntityManagement/get_legal_entity.json")

      url = client.service_url("LegalEntityManagement", "legalEntities/#{legal_entity_id}", "1")
      WebMock.stub_request(:get, url).
        to_return(
          body: response_body
        )

      result = client.legal_entity_management.get_legal_entity(legal_entity_id)
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
      request_body = JSON.parse(json_from_file("mocks/requests/LegalEntityManagement/update_transfer_instrument.json"))

      response_body = json_from_file("mocks/responses/LegalEntityManagement/update_transfer_instrument.json")

      url = client.service_url("LegalEntityManagement", "transferInstruments/#{transferInstrumentId}", "1")
      WebMock.stub_request(:patch, url).
        with(
          body: request_body
        ).
        to_return(
          body: response_body
        )

      result = client.legal_entity_management.update_transfer_instrument(request_body, transferInstrumentId)
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

      response_body = json_from_file("mocks/responses/LegalEntityManagement/get_transfer_instrument.json")

      url = client.service_url("LegalEntityManagement", "transferInstruments/#{transferInstrumentId}", "1")
      WebMock.stub_request(:get, url).
        to_return(
          body: response_body
        )

      result = client.legal_entity_management.get_transfer_instrument(transferInstrumentId)
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

      url = client.service_url("LegalEntityManagement", "transferInstruments/#{transferInstrumentId}", "1")
      WebMock.stub_request(:delete, url).
        to_return(
          body: "",
          status: 204
        )

      result = client.legal_entity_management.delete_transfer_instrument(transferInstrumentId)
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
      request_body = JSON.parse(json_from_file("mocks/requests/LegalEntityManagement/update_document.json"))

      response_body = json_from_file("mocks/responses/LegalEntityManagement/update_document.json")

      url = client.service_url("LegalEntityManagement", "documents/#{documentId}", "1")
      WebMock.stub_request(:patch, url).
        with(
          body: request_body
        ).
        to_return(
          body: response_body
        )

      result = client.legal_entity_management.update_document(request_body, documentId)
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

      response_body = json_from_file("mocks/responses/LegalEntityManagement/get_document.json")

      url = client.service_url("LegalEntityManagement", "documents/#{documentId}", "1")
      WebMock.stub_request(:get, url).
        to_return(
          body: response_body
        )

      result = client.legal_entity_management.get_document(documentId)
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
      documentId = "SE322JV223222D5DVD85RCGHR"

      url = client.service_url("LegalEntityManagement", "documents/#{documentId}", "1")
      WebMock.stub_request(:delete, url).
        to_return(
          body: "",
          status: 204
        )

      result = client.legal_entity_management.delete_document(documentId)
      response_hash = result.response

      expect(result.status).
        to eq(204)
      expect(response_hash).
        to eq("")
    end
  end

  context "business lines" do
    it "gets a business line" do
      line_id = "SE322JV223222D5FKLGQPC2H5"

      response_body = json_from_file("mocks/responses/LegalEntityManagement/get_business_line.json")

      url = client.service_url("LegalEntityManagement", "businessLines/#{line_id}", "1")
      WebMock.stub_request(:get, url).
      to_return(
        body: response_body
      )

      result = client.legal_entity_management.get_business_line(line_id)
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

    it "updates a businessLine" do
      line_id = "SE322JV223222D5DTMZBK44M5"
      request_body = JSON.parse(json_from_file("mocks/requests/LegalEntityManagement/update_business_line.json"))

      response_body = json_from_file("mocks/responses/LegalEntityManagement/update_business_line.json")

      url = client.service_url("LegalEntityManagement", "businessLines/#{line_id}", "1")
      WebMock.stub_request(:patch, url).
        with(
          body: request_body
        ).
        to_return(
          body: response_body
        )

      result = client.legal_entity_management.update_business_line(request_body, line_id)
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

    it "deletes a businessLine" do
      line_id = "SE322JV223222D5DVD85RCGHR"

      url = client.service_url("LegalEntityManagement", "businessLines/#{line_id}", "1")
      WebMock.stub_request(:delete, url).
        to_return(
          body: "",
          status: 204
        )

      result = client.legal_entity_management.delete_business_line(line_id)
      response_hash = result.response

      expect(result.status).
        to eq(204)
      expect(response_hash).
        to eq("")
    end
  end

  generate_tests(client, "LegalEntityManagement", test_sets, client.legal_entity_management)
end
