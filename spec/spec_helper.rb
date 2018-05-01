require "webmock/rspec"
require "base64"
require_relative "../lib/adyen"

# disable external connections
WebMock.disable_net_connect!(allow_localhost: true)

# prepends location of this file onto filepath
# and returns contents of file as string
def json_from_file(filepath)
  File.read("#{File.dirname(__FILE__)}/#{filepath}")
end

# boilerplate test scenario
# returns hash of response from client
def create_test(shared_values, method_name, parent_object)
  # pull request and response from json files
  request_body = json_from_file("mocks/requests/#{shared_values[:service]}/#{method_name}.json")
  response_body = json_from_file("mocks/responses/#{shared_values[:service]}/#{method_name}.json")

  # client-generated headers
  headers = {
    'Accept': '*/*',
    'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'Content-Type': 'application/json',
    'User-Agent': 'Faraday v0.14.0'
  }

  # authentication headers
  if not shared_values["x-api-key"].nil? then
    headers["X-Api-Key"] = shared_values["x-api-key"]
  elsif not shared_values["ws_user"].nil? and not shared_values["ws_password"].nil? then
    auth_header = "Basic " + Base64::encode64("#{shared_values["ws_user"]}:#{shared_values["ws_password"]}")
    headers["Authorization"] = auth_header
  end

  # stub request
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

  # boilerplate error checks
  expect(response.status).
    to eq(200)
  expect(response.body).
    to eq(response_body)
  expect((parsed_body = JSON.parse(response.body)).class).
    to be Hash

  # return hash of response
  parsed_body
end

# creates tests from an array of arrays
# format:
# [method name, test parameter in mock response, expected value of test parameter]
def generate_test(shared_values, test_set, parent_object)
  parsed_body = create_test(shared_values, test_set[0], parent_object)
  expect(parsed_body[test_set[1]]).
    to eq(test_set[2])
end
