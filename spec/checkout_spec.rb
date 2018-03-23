require "spec_helper"
require "json"
require_relative "../lib/adyen/errors"

RSpec.describe Adyen::Checkout, service: "checkout" do
  before(:all) do
    @shared_values = {
      client: nil,
      # merchant_account: "<your TEST merchant account>",
      # api_key: "<your TEST Checkout API key>",
      merchant_account: "ColinRood",
      api_key: "AQEyhmfxLIrIaBdEw0m/n3Q5qf3VaY9UCJ1+XWZe9W27jmlZilETQsVk1ULvYgY9gREbDhYQwV1bDb7kfNy1WIxIIkxgBw==-CekguSzLVE/iCTVQQWGILQK0x8Lo88FEQ/VHTZuAoP0=-dqZewkA79CPfNISf",
      test_payment_method: "card", # can be card, ideal
      test_payment_currency: "EUR"
    }
  end

  it "creates Adyen client" do
    @shared_values[:client] = Adyen::Client.new
    expect(@shared_values[:client]).not_to be nil
  end

  it "sets env to :test" do
    @shared_values[:client].env = :test
    expect(@shared_values[:client].env).to eq(:test)
  end

  context "checkout API" do
    it "fails checkout call without API key" do
      expect{ @shared_values[:client].checkout.payment_methods("{}") }.to raise_error(Adyen::PermissionError)
    end

    it "sets API key" do
      @shared_values[:client].api_key = @shared_values[:api_key]
      expect(@shared_values[:client].api_key).to eq(@shared_values[:api_key])
    end

    it "returns a JSON object from a payment_methods call" do
      response = @shared_values[:client].checkout.payment_methods("{
        \"merchantAccount\": \"#{@shared_values[:merchant_account]}\"
        }")
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).class).to be Hash
    end

    it "submits a test payment" do
      case @shared_values[:test_payment_method]
      when "card"
        response = @shared_values[:client].checkout.payments("{
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
          \"merchantAccount\": \"#{@shared_values[:merchant_account]}\"
        }")
      when "ideal"
        response = @shared_values[:client].checkout.payments("{
          \"amount\": {
            \"currency\": \"#{@shared_values[:test_payment_currency]}\",
            \"value\": 1000
          },
          \"reference\": \"Ruby SDK test transaction\",
          \"paymentMethod\": {
            \"type\": \"ideal\",
            \"idealIssuer\": 1155
          },
          \"returnUrl\": \"\",
          \"merchantAccount\": \"#{@shared_values[:merchant_account]}\"
        }")
      end

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["resultCode"]).to eq("Authorised")
    end

    it "completes a setup call successfully" do
      response = @shared_values[:client].checkout.setup("{
        \"amount\": {
          \"value\": 1500,
          \"currency\": \"#{@shared_values[:test_payment_currency]}\"
        },
        \"returnUrl\": \"www.example.com\",
        \"countryCode\": \"US\",
        \"reference\": \"Ruby SDK test transaction\",
        \"merchantAccount\": \"#{@shared_values[:merchant_account]}\"
      }")

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["paymentData"]).to_not be nil
    end
  end
end
