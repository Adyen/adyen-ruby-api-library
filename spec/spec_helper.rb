require "webmock/rspec"
require "base64"
require_relative "../lib/adyen-ruby-api-library"

# disable external connections
WebMock.disable_net_connect!(allow_localhost: true)

# prepends location of this file onto filepath
# and returns contents of file as string
def json_from_file(filepath)
  File.read("#{File.dirname(__FILE__)}/#{filepath}")
end

# boilerplate test scenario
# returns hash of response from client
def create_test(client, service, method_name, parent_object)
  # pull request and response from json files
  request_body = JSON.parse(json_from_file("mocks/requests/#{service}/#{method_name}.json"))
  response_body = json_from_file("mocks/responses/#{service}/#{method_name}.json")


  if service == 'Checkout' || service == 'CheckoutUtility'
    client.add_application_info(request_body)
  end

  # client-generated headers
  headers = {
    'Content-Type'.to_sym => 'application/json'
  }

  # authentication headers
  if not client.api_key.nil? then
    headers["x-api-key"] = client.api_key
  elsif not client.ws_user.nil? and not client.ws_password.nil? then
    auth_header = "Basic " + Base64::encode64("#{client.ws_user}:#{client.ws_password}")
    headers["Authorization"] = auth_header.strip
  else
    raise ArgumentError, "Authentication not set correctly in test case"
  end

  # stub request
  url = client.service_url(service, method_name.to_camel_case, parent_object.version)
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
# test_set format:
# [method name, test parameter in mock response, expected value of test parameter]
def generate_tests(client, service, test_sets, parent_object)
  test_sets.each do |test_set|
    it "makes a #{test_set[0]} call" do
      parsed_body = create_test(client, service, test_set[0], parent_object)
      expect(parsed_body[test_set[1]]).
        to eq(test_set[2])
    end
  end
end

# create and return a client for testing
# auth_type must be one of [:basic, :api_key]
def create_client(auth_type)
  client = Adyen::Client.new
  client.env = :mock

  if auth_type == :basic then
    client.ws_user = "user"
    client.ws_password = "password"
  elsif auth_type == :api_key then
    client.api_key = "api_key"
  else
    raise ArgumentError "Invalid auth type for test client"
  end

  client
end
