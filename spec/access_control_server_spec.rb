require "spec_helper"

RSpec.describe Adyen::AccessControlServer, service: "AccessControlServer" do
  client = create_client(:api_key)

  context "challenges" do
    it "finalizes an authentication challenge" do
      authenticate_header = "abc"
      authparm_header = "eyJjaGFsbGVuZ2UiOiJiVlV6ZW5wek0waFNlQzF"
      authentication_challenge_id = "123"
      request_body = JSON.parse(json_from_file("mocks/requests/AccessControlServer/finalize_authentication.json"))
      response_body = json_from_file("mocks/responses/AccessControlServer/finalize_authentication.json")
  
      url = client.service_url("AccessControlServer", "challenges/#{authentication_challenge_id}", "1")

      WebMock.stub_request(:patch, url).
        with(
          headers: {
            "x-api-key" => client.api_key,
            "WWW-Authenticate" => authenticate_header,
            "authparm1" => authparm_header
          }
        ).
        to_return(
          body: response_body
        )

      result = client.access_control_server.finalize_authentication(
        request_body,
        authentication_challenge_id,
        { "WWW-Authenticate" => authenticate_header, "authparm1" => authparm_header }
      )
      response_hash = result.response
  
      expect(result.status).
        to eq(200)
      expect(response_hash).
        to eq(JSON.parse(response_body))
      expect(response_hash).
        to be_a Adyen::HashWithAccessors
      expect(response_hash).
        to be_a_kind_of Hash
    end
  end
end
