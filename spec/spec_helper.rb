require "webmock/rspec"
require_relative "../lib/adyen"

# disable external connections
WebMock.disable_net_connect!(allow_localhost: true)

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

  headers = {
    'Accept': '*/*',
    'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'Content-Type': 'application/json',
    'User-Agent': 'Faraday v0.14.0'
  }
  headers["X-Api-Key"] = shared_values["x-api-key"] unless shared_values["x-api-key"].nil?

  url = shared_values[:client].service_url(shared_values[:service], method_name.to_camel_case, shared_values[:version])
  WebMock.stub_request(:post, url).
    with(
      body: request_body,
      headers: headers
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
