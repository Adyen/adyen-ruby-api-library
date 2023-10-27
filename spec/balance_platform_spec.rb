require 'spec_helper'
require 'json'

RSpec.describe Adyen::BalancePlatform, service: 'balancePlatform' do
  before(:all) do
    @shared_values = {
      client: create_client(:api_key),
      service: 'BalancePlatform'
    }
  end

  # must be created manually because every field in the response is an array
  it 'makes a account_holder POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/create_account_holder.json'))

    response_body = json_from_file('mocks/responses/BalancePlatform/create_account_holder.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'accountHolders',
                                              @shared_values[:client].balance_platform.version)
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: response_body
           )

    result = @shared_values[:client].balance_platform.account_holders_api.create_account_holder(request_body)
    response_hash = result.response

    expect(result.status)
      .to eq(200)
    expect(response_hash)
      .to eq(JSON.parse(response_body))
    expect(response_hash)
      .to be_a Adyen::HashWithAccessors
    expect(response_hash)
      .to be_a_kind_of Hash
  end

  it 'makes a account_holder PATCH call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/update_account_holder.json'))

    response_body = json_from_file('mocks/responses/BalancePlatform/update_account_holder.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'accountHolders/AH3227C223222C5GKR23686TF',
                                              @shared_values[:client].balance_platform.version)
    WebMock.stub_request(:patch, url)
           .with(
             body: request_body,
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: response_body
           )

    result = @shared_values[:client].balance_platform.account_holders_api.update_account_holder(
      request_body,
      'AH3227C223222C5GKR23686TF'
    )
    response_hash = result.response

    expect(result.status)
      .to eq(200)
    expect(response_hash)
      .to eq(JSON.parse(response_body))
    expect(response_hash)
      .to be_a Adyen::HashWithAccessors
    expect(response_hash)
      .to be_a_kind_of Hash
  end

  it 'makes a balance_account GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_balance_account.json')

    url = @shared_values[:client].service_url(@shared_values[:service], 'balanceAccounts/BA3227C223222B5BLP6JQC3FD',
                                              @shared_values[:client].balance_platform.version)
    WebMock.stub_request(:get, url)
           .with(
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: response_body
           )

    result = @shared_values[:client].balance_platform.balance_accounts_api
                                    .get_balance_account('BA3227C223222B5BLP6JQC3FD')
    response_hash = result.response

    expect(result.status)
      .to eq(200)
    expect(response_hash)
      .to eq(JSON.parse(response_body))
    expect(response_hash)
      .to be_a Adyen::HashWithAccessors
    expect(response_hash)
      .to be_a_kind_of Hash
  end

  it 'makes a balance_account/sweeps DELETE call' do
    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'balanceAccounts/balanceAccountID/sweeps/sweepID',
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:delete, url)
           .with(
             headers: {
               'x-api-key' => @shared_values[:client].api_key
             }
           )
           .to_return(
             body: '{}'
           )

    result = @shared_values[:client].balance_platform.balance_accounts_api.delete_sweep('balanceAccountID', 'sweepID')
    result.response

    expect(result.status)
      .to eq(200)
  end

  context "publicKey" do
    it "gets a public key" do
      response_body = json_from_file('mocks/responses/BalancePlatform/get_public_key.json')

      url = @shared_values[:client].service_url(@shared_values[:service], 'publicKey?purpose=pinReveal',
                                                @shared_values[:client].balance_platform.version)
      WebMock.stub_request(:get, url)
            .with(
              headers: {
                'x-api-key' => @shared_values[:client].api_key
              }
            )
            .to_return(
              body: response_body
            )

      result = @shared_values[:client].balance_platform.get_public_key("pinReveal")

      response_hash = result.response

      expect(result.status)
        .to eq(200)
      expect(response_hash)
        .to eq(JSON.parse(response_body))
      expect(response_hash)
        .to be_a Adyen::HashWithAccessors
      expect(response_hash)
        .to be_a_kind_of Hash
    end
  end

  context "pin reveal" do
    it "retrieves the encrypted pin" do
      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/pin_reveal.json"))
      response_body = json_from_file("mocks/responses/BalancePlatform/pin_reveal.json")

      url = @shared_values[:client].service_url(@shared_values[:service], 'pins/reveal',
                                                @shared_values[:client].balance_platform.version)
      WebMock.stub_request(:post, url).
        with(
          body: request_body,
          headers: {
            "x-api-key" => @shared_values[:client].api_key
          }
        ).
        to_return(
          body: response_body
        )

      result = @shared_values[:client].balance_platform.get_payment_instrument_pin(request_body)
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

  context "registeredDevices" do
    it "creates a registeredDevice" do
      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/create_registered_device.json"))
      response_body = json_from_file("mocks/responses/BalancePlatform/create_registered_device.json")

      url = @shared_values[:client].service_url(@shared_values[:service], 'registeredDevices',
                                                @shared_values[:client].balance_platform.version)

      WebMock.stub_request(:post, url).
        with(
          headers: {
            "x-api-key" => @shared_values[:client].api_key
          }
        ).
        to_return(
          body: response_body
        )

        result = @shared_values[:client].balance_platform.create_registered_device(request_body)
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

    it "updates a registeredDevice" do
      registered_device_id = "RD32275223224S5GKPPPH2B66"

      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/update_registered_device.json"))
      response_body = json_from_file("mocks/responses/BalancePlatform/update_registered_device.json")

      url = @shared_values[:client].service_url(@shared_values[:service], "registeredDevices/#{registered_device_id}", @shared_values[:client].balance_platform.version)

      WebMock.stub_request(:patch, url).
        with(
          headers: {
            "x-api-key" => @shared_values[:client].api_key
          }
        ).
        to_return(
          body: response_body
        )

        result = @shared_values[:client].balance_platform.update_registered_device(request_body, registered_device_id)
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

  context 'transfer routes' do
    let(:platform) { client.balance_platform }

    before do
      platform.version = 1
    end

    it 'calculates a transfer route' do
      request_body = JSON.parse(json_from_file("mocks/requests/BalancePlatform/calculate_transfer_route.json"))
      response_body = json_from_file("mocks/responses/BalancePlatform/calculate_transfer_route.json")

      url = client.service_url("BalancePlatform", "transferRoutes/calculate", "1")
      WebMock.stub_request(:post, url).
        with(
          body: request_body,
          headers: {
            "x-api-key" => client.api_key
          }
        ).
        to_return(
          body: response_body
        )

      result = client.balance_platform.calculate_transfer_route(request_body)
      response_hash = result.response

      expect(result.status).
        to eq(200)
      expect(response_hash).
        to eq(JSON.parse(response_body))
    end
  end

  generate_tests(client, "BalancePlatform", test_sets, client.balance_platform)
end
