require "spec_helper"

RSpec.describe Adyen::Payments, service: "payments" do
  before(:all) do
    @shared_values = { client: nil }
  end

  it "creates Adyen client" do
    @shared_values[:client] = Adyen::Client.new
    expect(@shared_values[:client]).not_to be nil
  end

  context "payments API" do
    it "fails payments call without WS user and password" do
      expect{ @shared_values[:client].payments.authorise("{}") }.to raise_error(ArgumentError)
      @shared_values[:client].ws_user = "user"
      expect{ @shared_values[:client].payments.authorise("{}") }.to raise_error(ArgumentError)
    end

    it "sets webservice user and password" do
      @shared_values[:client].ws_password = "password"
      expect(@shared_values[:client].ws_password).to eq("password")
    end
  end
end
