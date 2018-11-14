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
    expect(client.service_url_base(@shared_values[:service])).to eq("https://checkout-test.adyen.com")
  end

  # must be created manually because every field in the response is an array
  it "makes an origin_keys call" do
    parsed_body = create_test(@shared_values[:client], @shared_values[:service], "origin_keys", @shared_values[:client].checkout_utility)
    expect(parsed_body["originKeys"].class).
      to be Hash
  end
end

# rubocop:enable Metrics/BlockLength
