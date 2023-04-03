require "spec_helper"

RSpec.describe Adyen do
  before(:all) do
    @shared_values = {
      client: nil
    }
  end

  it "creates Adyen client" do
    @shared_values[:client] = Adyen::Client.new
    expect(@shared_values[:client]).is_a? Adyen::Client
  end

  it "sets env to :mock" do
    @shared_values[:client].env = :test
    expect(@shared_values[:client].env).
      to eq(:test)
  end

  it "sets the version number" do
    @shared_values[:client].checkout.version = @shared_values[:version]
    expect(@shared_values[:client].checkout.version).
      to eq(@shared_values[:version])
  end

  it "fails payments call without WS user and password" do
    expect{ @shared_values[:client].payments.authorise("{}") }.
      to raise_error(Adyen::AuthenticationError)
    @shared_values[:client].ws_user = @shared_values[:ws_user]
    expect{ @shared_values[:client].payments.authorise("{}") }.
      to raise_error(Adyen::AuthenticationError)
  end

  it "fails a checkout call without api key" do
    expect{ @shared_values[:client].checkout.payments_api.payment_methods("{}") }.
      to raise_error(Adyen::AuthenticationError)
    @shared_values[:client].api_key = "api_key"
  end

  it "uses the specified mock service URL" do
    client = Adyen::Client.new(env: :mock, mock_service_url_base: "https://mock.test")
    expect(client.service_url_base("Account")).
      to eq("https://mock.test")
  end

  it "generates localhost service URL when a mock port is specified" do
    client = Adyen::Client.new(env: :mock, mock_port: 3005)
    expect(client.service_url_base("Account")).
      to eq("http://localhost:3005")
  end

  it "prefers the mock service URL when both mock service URL and port are specified" do
    client = Adyen::Client.new(env: :mock, mock_port: 3005, mock_service_url_base: "https://this-url-wins.test")
    expect(client.service_url_base("Account")).
      to eq("https://this-url-wins.test")
  end

  it "generates the correct service URL base for CAL TEST" do
    client = Adyen::Client.new(env: :test)
    client.live_url_prefix = "abcdef1234567890-TestCompany"
    expect(client.service_url_base("Account")).
      to eq("https://cal-test.adyen.com/cal/services")
  end

  it "generates the correct service URL base for CAL LIVE" do
    client = Adyen::Client.new(env: :live)
    client.live_url_prefix = "abcdef1234567890-TestCompany"
    expect(client.service_url_base("Account")).
      to eq("https://cal-live.adyen.com/cal/services")
  end

  it "generates the correct service URL base for PAL TEST" do
    client = Adyen::Client.new(env: :test)
    client.live_url_prefix = "abcdef1234567890-TestCompany"
    expect(client.service_url_base("Payment")).
      to eq("https://pal-test.adyen.com/pal/servlet")
  end

  it "generates the correct service URL base for PAL LIVE" do
    client = Adyen::Client.new(env: :live)
    client.live_url_prefix = "abcdef1234567890-TestCompany"
    expect(client.service_url_base("Payment")).
      to eq("https://abcdef1234567890-TestCompany-pal-live.adyenpayments.com/pal/servlet")
  end

  it "generates a new set of ConnectionOptions when none are provided" do
    expect(Faraday::ConnectionOptions).to receive(:new).and_call_original
    client = Adyen::Client.new(env: :test)
  end

  it "uses the ConnectionOptions provided" do
    connection_options = Faraday::ConnectionOptions.new
    expect(Faraday::ConnectionOptions).not_to receive(:new)
    client = Adyen::Client.new(env: :test, connection_options: connection_options)
  end

  it "initiates a Faraday connection with the provided options" do
    connection_options = Faraday::ConnectionOptions.new
    expect(Faraday::ConnectionOptions).not_to receive(:new)
    client = Adyen::Client.new(api_key: "api_key", env: :mock, connection_options: connection_options)

    mock_faraday_connection = double(Faraday::Connection)
    url = client.service_url(@shared_values[:service], "payments/details", client.checkout.version)
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment-details.json"))
    mock_response = Faraday::Response.new(status: 200)

    expect(Adyen::AdyenResult).to receive(:new)
    expect(Faraday).to receive(:new).with("http://localhost:3001/v70/payments/details", connection_options).and_return(mock_faraday_connection)
    expect(mock_faraday_connection).to receive(:post).and_return(mock_response)
    client.checkout.payments_api.payments_details(request_body)
  end
end
