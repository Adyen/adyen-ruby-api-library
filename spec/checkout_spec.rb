require "spec_helper"
require "json"

# rubocop:disable Metrics/BlockLength

RSpec.describe Adyen::Checkout, service: "checkout" do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: "Checkout",
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
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment-details.json"))
    @shared_values[:client].add_application_info(request_body)

    response_body = json_from_file("mocks/responses/Checkout/payment-details.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/details", @shared_values[:client].checkout.version)
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

  # must be created manually due to payments/result format
  it "makes a payments/result call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment-result.json"))
    @shared_values[:client].add_application_info(request_body)

    response_body = json_from_file("mocks/responses/Checkout/payment-result.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/result", @shared_values[:client].checkout.version)
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
    response = @shared_values[:client].checkout.payments.result(request_body)

    expect(response.status).
      to eq(200)
    expect(response.body).
      to eq(response_body)
    expect((parsed_body = JSON.parse(response.body)).class).
      to be Hash
    expect(parsed_body["resultCode"]).
      to eq("Authorised")
  end

  # create client for automated tests
  client = create_client(:api_key)

  # methods / fields to test on
  # format is defined in spec_helper
  test_sets = [
    ["payment_session", "publicKeyToken", "8115054323780109"],
    ["payments", "resultCode", "Authorised"]
  ]

  generate_tests(client, "Checkout", test_sets, client.checkout)
end

# rubocop:enable Metrics/BlockLength
