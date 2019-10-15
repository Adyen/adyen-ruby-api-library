require "spec_helper"
require "json"

# rubocop:disable Metrics/BlockLength

RSpec.describe Adyen::CheckoutUtility, service: "checkout utility" do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: "CheckoutUtility",
    }
  end

  it "sets the correct service URL base" do
    client = Adyen::Client.new(env: :test)
    expect(client.service_url_base(@shared_values[:service])).to eq("https://checkout-test.adyen.com/checkout")
  end
end

# rubocop:enable Metrics/BlockLength
