require "spec_helper"
require "json"
require_relative "../lib/adyen/errors"

# rubocop:disable Metrics/BlockLength

RSpec.describe Adyen::Checkout, service: "checkout" do
  before(:all) do
    @shared_values = {
      client: nil,
      test_merchant_account: "TestMerchant",
      test_api_key: "test_api_key",
      test_payment_currency: "EUR",
      service: "PaymentSetupAndVerification",
      version: 32
    }
  end

  it "creates Adyen client" do
    @shared_values[:client] = Adyen::Client.new
    expect(@shared_values[:client]).not_to be nil
  end

  it "sets env to :mock" do
    @shared_values[:client].env = :mock
    expect(@shared_values[:client].env).to eq(:mock)
  end

  context "checkout API" do
    it "fails checkout call without API key" do
      expect{ @shared_values[:client].checkout.payment_methods("{}") }.
        to raise_error(Adyen::PermissionError)
    end

    it "sets API key" do
      @shared_values[:client].api_key = @shared_values[:test_api_key]
      expect(@shared_values[:client].api_key).to eq(@shared_values[:test_api_key])
    end

    it "rejects a request which is missing required parameters" do
      request_body = "{}"
      expect{ @shared_values[:client].checkout.payment_methods(request_body) }.
        to raise_error(Adyen::ValidationError)
    end

    it "returns a JSON object from a payment_methods call" do
      request_body = "{
        \"merchantAccount\": \"#{@shared_values[:test_merchant_account]}\"
      }"
      response_body = '{
        "paymentMethods": [
          { "name": "Method1", "type": "Method1" },
          { "name": "Method2", "type": "Method2" }
        ]
      }'

      url = @shared_values[:client].service_url(@shared_values[:service], "paymentMethods", @shared_values[:version])
      WebMock.stub_request(:post, url).
        with(
          body: request_body,
          headers: { "x-api-key" => @shared_values[:test_api_key] }
        ).
        to_return(
          body: response_body
        )
      response = @shared_values[:client].checkout.payment_methods(request_body)

      expect(response.status).
        to eq(200)
      expect(JSON.parse(response.body).class).
        to be Hash
      expect(response.body).
        to eq(response_body)
    end

    it "submits a test payment" do
      request_body = "{
        \"amount\": {
          \"currency\": \"#{@shared_values[:test_payment_currency]}\",
          \"value\": 1000
        },
        \"reference\": \"Ruby SDK test transaction\",
        \"paymentMethod\": {
          \"type\": \"scheme\",
          \"number\": \"4111111111111111\",
          \"expiryMonth\": \"08\",
          \"expiryYear\": \"2018\",
          \"holderName\": \"John Smith\",
          \"cvc\": \"737\"
        },
        \"returnUrl\": \"\",
        \"merchantAccount\": \"#{@shared_values[:test_merchant_account]}\"
      }"
      response_body = '{
        "pspReference": "8525224486862747",
        "resultCode": "Authorised"
      }'

      url = @shared_values[:client].service_url(@shared_values[:service], "payments", @shared_values[:version])
      WebMock.stub_request(:post, url).
        with(
          body: request_body,
          headers: { "x-api-key" => @shared_values[:test_api_key] }
        ).
        to_return(
          body: response_body
        )
      response = @shared_values[:client].checkout.payments(request_body)

      expect(response.status).
        to eq(200)
      expect(JSON.parse(response.body).class).
        to be Hash
      expect(response.body).
        to eq(response_body)
    end

    it "completes a setup call successfully" do
      request_body = "{
        \"amount\": {
          \"value\": 1500,
          \"currency\": \"#{@shared_values[:test_payment_currency]}\"
        },
        \"channel\": \"Web\",
        \"returnUrl\": \"www.example.com\",
        \"countryCode\": \"US\",
        \"reference\": \"Ruby SDK test transaction\",
        \"merchantAccount\": \"#{@shared_values[:test_merchant_account]}\"
      }"

      response_body = '{
        "disableRecurringDetailUrl": "someURL",
        "generationTime": "2018-04-03T22:52:19Z",
        "html": "<body></body>"
      }'

      url = @shared_values[:client].service_url(@shared_values[:service], "setup", @shared_values[:version])
      WebMock.stub_request(:post, url).
        with(
          body: request_body,
          headers: { "x-api-key" => @shared_values[:test_api_key] }
        ).
        to_return(
          body: response_body
        )
      response = @shared_values[:client].checkout.setup(request_body)

      expect(response.status).
        to eq(200)
      expect(JSON.parse(response.body).class).
        to be Hash
      expect(response.body).
        to eq(response_body)
    end
  end
end

# rubocop:enable Metrics/BlockLength
