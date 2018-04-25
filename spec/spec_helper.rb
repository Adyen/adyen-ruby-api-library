require "webmock/rspec"
require_relative "../lib/adyen"

# disable external connections
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# prepends file directory onto filepath
# and returns contents of file as string
def json_from_file(filepath)
  File.read("#{File.dirname(__FILE__)}/#{filepath}")
end

# boilerplate test scenario
# returns hash of response from client
def create_test(shared_values, method_name, parent_object)
  request_body = json_from_file("mocks/requests/#{shared_values[:service]}/#{method_name}.json")
  response_body = json_from_file("mocks/responses/#{shared_values[:service]}/#{method_name}.json")

  url = shared_values[:client].service_url(shared_values[:service], method_name.to_camel_case, shared_values[:version])
  WebMock.stub_request(:post, url).
    with(
      body: request_body,
      headers: { "x-api-key" => @shared_values[:test_api_key] }
    ).
    to_return(
      body: response_body
    )
  response = parent_object.public_send(method_name, request_body)

  expect(response.status).
    to eq(200)
  expect(response.body).
    to eq(response_body)
  expect((parsed_body = JSON.parse(response.body)).class).
    to be Hash

  parsed_body
end
