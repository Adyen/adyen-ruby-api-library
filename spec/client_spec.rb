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
    expect{ @shared_values[:client].checkout.payment_methods("{}") }.
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
end
