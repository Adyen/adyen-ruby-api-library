require "spec_helper"

RSpec.describe Adyen::Checkout, service: "checkout" do
  before(:all) do
    @shared_values = { client: nil }
  end

  it "creates Adyen client" do
    @shared_values[:client] = Adyen::Client.new
    expect(@shared_values[:client]).not_to be nil
  end

  context "checkout API" do
    it "fails checkout call without API key" do
      expect{ @shared_values[:client].checkout.paymentMethods("{}") }.to raise_error(ArgumentError)
    end

    it "sets API key" do
      @shared_values[:client].api_key = @shared_values[:api_key]
      expect(@shared_values[:client].api_key).to eq(@shared_values[:api_key])
    end
  end
end
