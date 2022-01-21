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
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment_methods.json"))

    response_body = json_from_file("mocks/responses/Checkout/payment_methods.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentMethods", @shared_values[:client].checkout.version)
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

    result = @shared_values[:client].checkout.payment_methods(request_body)
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

  it "makes a paymentMethods/balance call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment_methods_balance.json"))
    request_body[:applicationInfo] = {}
    request_body[:applicationInfo][:adyenPaymentSource] = {
      :name => "adyen-test",
      :version => "1.0.0",
    }

    @shared_values[:client].add_application_info(request_body)

    response_body = json_from_file("mocks/responses/Checkout/payment_methods_balance.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentMethods/balance", @shared_values[:client].checkout.version)
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

    result = @shared_values[:client].checkout.payment_methods.balance(request_body)
    # result.response is already a Ruby hash (rather than an unparsed JSON string)
    response_hash = result.response

    expect(request_body[:applicationInfo][:adyenLibrary][:name]).
      to eq(Adyen::NAME)
    expect(request_body[:applicationInfo][:adyenLibrary][:version]).
      to eq(Adyen::VERSION)
    expect(request_body[:applicationInfo][:adyenPaymentSource][:name]).
      to eq("adyen-test")
    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["balance"]).
      to eq("100")
  end

  # must be created manually due to payments/details format
  it "makes a payments/details call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment-details.json"))
    request_body[:applicationInfo] = {}
    request_body[:applicationInfo][:adyenPaymentSource] = {
      :name => "adyen-test",
      :version => "1.0.0",
    }

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

    result = @shared_values[:client].checkout.payments.details(request_body)
    # result.response is already a Ruby hash (rather than an unparsed JSON string)
    response_hash = result.response

    expect(request_body[:applicationInfo][:adyenLibrary][:name]).
      to eq(Adyen::NAME)
    expect(request_body[:applicationInfo][:adyenLibrary][:version]).
      to eq(Adyen::VERSION)
    expect(request_body[:applicationInfo][:adyenPaymentSource][:name]).
      to eq("adyen-test")
    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["resultCode"]).
      to eq("RedirectShopper")
    expect(response_hash.resultCode).
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

    result = @shared_values[:client].checkout.payments.result(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["resultCode"]).
      to eq("Authorised")
    expect(response_hash.resultCode).
      to eq("Authorised")
  end

  # must be created manually due to paymentsLinks format
  it "makes a paymentLinks call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment_links.json"))
    request_body[:applicationInfo] = {}
    request_body[:applicationInfo][:adyenPaymentSource] = {
      :name => "adyen-test",
      :version => "1.0.0",
    }

    @shared_values[:client].add_application_info(request_body)

    response_body = json_from_file("mocks/responses/Checkout/payment_links.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentLinks", @shared_values[:client].checkout.version)
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

    result = @shared_values[:client].checkout.payment_links(request_body)
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

  # must be created manually due to paymentsLinks/{linkId} format
  it "makes a get paymentLinks/{linkId} call" do
    response_body = json_from_file("mocks/responses/Checkout/get-payment-link.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentLinks/1", @shared_values[:client].checkout.version)
    WebMock.stub_request(:get, url).
      with(
        headers: {
          "x-api-key" => @shared_values[:client].api_key
        }
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.payment_links.get("1")
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["status"]).
      to eq("active")
    expect(response_hash.id).
      to eq("MockId")
  end

  # must be created manually due to paymentsLinks/{linkId} format
  it "makes a patch paymentLinks/{linkId} call" do
    request_body = {
      :status => "expired",
    }

    @shared_values[:client].add_application_info(request_body)
    response_body = json_from_file("mocks/responses/Checkout/update-payment-link.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentLinks/1", @shared_values[:client].checkout.version)
    WebMock.stub_request(:patch, url).
      with(
        body: request_body,
        headers: {
          "x-api-key" => @shared_values[:client].api_key
        }
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.payment_links.update("1", request_body)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["status"]).
      to eq("expired")
    expect(response_hash.id).
      to eq("MockId")
  end

  it "makes an orders call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/orders.json"))

    response_body = json_from_file("mocks/responses/Checkout/orders.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "orders", @shared_values[:client].checkout.version)
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

    result = @shared_values[:client].checkout.orders(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["remainingAmount"]["value"]).
      to eq(100)
  end

  it "makes an orders/cancel call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/orders_cancel.json"))

    response_body = json_from_file("mocks/responses/Checkout/orders_cancel.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "orders/cancel", @shared_values[:client].checkout.version)
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

    result = @shared_values[:client].checkout.orders.cancel(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["resultCode"]).
      to eq("cancelled")
  end

  it "makes a sessions call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/sessions.json"))

    response_body = json_from_file("mocks/responses/Checkout/sessions-success.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "sessions", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: {
          "x-api-key" => @shared_values[:client].api_key
        }
      )
      .to_return(body: response_body, status: 201)

    result = @shared_values[:client].checkout.sessions(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(201)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
  end

  # create client for automated tests
  client = create_client(:api_key)

  # methods / fields to test on
  # format is defined in spec_helper
  test_sets = [
    ["payment_session", "publicKeyToken", "8115054323780109"],
    ["payments", "resultCode", "Authorised"],
    ["origin_keys", "originKeys", { "https://adyen.com" => "mocked_origin_key" }]
  ]

  generate_tests(client, "Checkout", test_sets, client.checkout)
end

# rubocop:enable Metrics/BlockLength
