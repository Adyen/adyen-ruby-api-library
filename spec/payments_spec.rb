require "spec_helper"
require_relative "../lib/adyen/errors"

# rubocop:disable Metrics/BlockLength

RSpec.describe Adyen::Payments, service: "payments service" do
  before(:all) do
    @shared_values = {
      client: nil,
      ws_user: "username",
      ws_password: "password",
      service: "Payment",
      version: 32
    }
  end

  it "creates Adyen client" do
    @shared_values[:client] = Adyen::Client.new
    expect(@shared_values[:client]).
      not_to be nil
  end

  it "sets env to :mock" do
    @shared_values[:client].env = :mock
    expect(@shared_values[:client].env).
      to eq(:mock)
  end

  it "sets the version number" do
    @shared_values[:client].payments.version = @shared_values[:version]
    expect(@shared_values[:client].payments.version).
      to eq(@shared_values[:version])
  end

  it "fails payments call without WS user and password" do
    expect{ @shared_values[:client].payments.authorise("{}") }.
      to raise_error(Adyen::AuthenticationError)
    @shared_values[:client].ws_user = @shared_values[:ws_user]
    expect{ @shared_values[:client].payments.authorise("{}") }.
      to raise_error(Adyen::AuthenticationError)
  end

  it "sets webservice user and password" do
    @shared_values[:client].ws_user = @shared_values[:ws_user]
    @shared_values[:client].ws_password = @shared_values[:ws_password]
    expect(@shared_values[:client].ws_user).
      to eq(@shared_values[:ws_user])
    expect(@shared_values[:client].ws_password).
      to eq(@shared_values[:ws_password])
  end

  it "rejects a request which is missing required parameters" do
    request_body = "{}"
    expect{ @shared_values[:client].payments.authorise(request_body) }.
      to raise_error(Adyen::ValidationError)
  end

  # creates tests from an array of arrays
  # format:
  # [method name, test parameter in mock response, expected value of test parameter]
  [
    ["authorise", "resultCode", "Authorised"],
    ["adjust_authorisation", "response", "[adjustAuthorisation-received]"],
    ["authorise3d", "resultCode", "Authorised"],
    ["cancel", "response", "[cancel-received]"],
    ["cancel_or_refund", "response", "[cancelOrRefund-received]"],
    ["capture", "response", "[capture-received]"],
    ["refund", "response", "[refund-received]"]
  ].map do |test_set|
    it "makes a #{test_set[0]} call" do
      generate_test(@shared_values, test_set, @shared_values[:client].payments)
    end
  end
end

# rubocop:enable Metrics/BlockLength
