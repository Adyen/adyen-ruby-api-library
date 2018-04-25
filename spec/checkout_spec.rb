require "spec_helper"
require "json"
require_relative "../lib/adyen/errors"
require_relative "../lib/adyen/validation"

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
      parsed_body = create_test(@shared_values, "payment_methods", @shared_values[:client].checkout)
      expect(parsed_body["paymentMethods"].class).
        to be Array
    end

    it "submits a test payment" do
      parsed_body = create_test(@shared_values, "payments", @shared_values[:client].checkout)
      expect(parsed_body["resultCode"]).
        to eq("Authorised")
    end

    # must be created manually due to payments/details format
    it "makes a payments/details call" do
      request_body = json_from_file("mocks/requests/PaymentSetupAndVerification/payment-details.json")
      response_body = json_from_file("mocks/responses/PaymentSetupAndVerification/payment-details.json")

      url = @shared_values[:client].service_url(@shared_values[:service], "payments/details", @shared_values[:version])
      WebMock.stub_request(:post, url).
        with(
          body: request_body,
          headers: { "x-api-key" => @shared_values[:test_api_key] }
        ).
        to_return(
          body: response_body
        )
      response = @shared_values[:client].checkout.payments.details(request_body)

      expect(response.status).
        to eq(200)
      expect(response.body).
        to eq(response_body)
      expect((parsed_body = JSON.parse(response.body)).class).
        to be Hash
      expect(parsed_body["resultCode"]).
        to eq("RedirectShopper")
    end
  end
end

# rubocop:enable Metrics/BlockLength
