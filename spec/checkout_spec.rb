require "spec_helper"
require "json"
require_relative "../lib/adyen/errors"

# rubocop:disable Metrics/BlockLength

RSpec.describe Adyen::Checkout, service: "checkout" do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      foobar: "foobar",
      service: "PaymentSetupAndVerification",
      version: 32
    }
  end

  # must be created manually because every field in the response is an array
  it "makes a payment_methods call" do
    parsed_body = create_test(@shared_values[:client], @shared_values[:service], "payment_methods", @shared_values[:client].checkout)
    expect(parsed_body["paymentMethods"].class).
      to be Array
  end

  # must be created manually due to payments/details format
  it "makes a payments/details call" do
    request_body = json_from_file("mocks/requests/PaymentSetupAndVerification/payment-details.json")
    response_body = json_from_file("mocks/responses/PaymentSetupAndVerification/payment-details.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/details", @shared_values[:version])
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: {
          "x-api-key" => @shared_values[:client].api_key
        }
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

  # create client for automated tests
  client = create_client(:api_key)

  # methods / fields to test on
  # format is defined in spec_helper
  test_sets = [
      ["setup", "publicKeyToken", "8115054323780109"],
      ["verify", "authResponse", "Authorised"],
      ["payments", "resultCode", "Authorised"]
    ]

    generate_tests(client, "PaymentSetupAndVerification", test_sets, client.checkout)
end

# rubocop:enable Metrics/BlockLength
