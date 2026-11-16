require 'spec_helper'

RSpec.describe Adyen do
  before(:each) do
    @shared_values = {
      client: Adyen::Client.new(env: :test)
    }
  end

  describe '#call_adyen_api' do
    let(:client) { Adyen::Client.new(api_key: 'api_key', env: :test) }
    let(:url) { client.service_url('Checkout', 'dispatch', '72') }
    let(:request_data) { { 'reference' => 'test-reference' } }
    let(:response_data) { { 'result' => 'success' } }

    ['put', 'head', 'options', 'GET', :get, nil, ''].each do |method|
      it "rejects unsupported HTTP method #{method.inspect} without sending a request" do
        request_stub = WebMock.stub_request(:any, url).to_return(body: '{}')

        expect {
          client.call_adyen_api('Checkout', { method: method, url: 'dispatch' }, request_data, {}, '72')
        }.to raise_error(ArgumentError, "Unsupported HTTP method: #{method.inspect}")

        expect(request_stub).not_to have_been_requested
      end
    end

    it 'raises KeyError without sending a request when the method is missing' do
      request_stub = WebMock.stub_request(:any, url).to_return(body: '{}')

      expect {
        client.call_adyen_api('Checkout', { url: 'dispatch' }, request_data, {}, '72')
      }.to raise_error(KeyError)

      expect(request_stub).not_to have_been_requested
    end

    %w[get delete patch post].each do |method|
      it "dispatches a #{method.upcase} request and preserves the response" do
        expected_body = %w[get delete].include?(method) ? '' : request_data.to_json
        request_stub = WebMock.stub_request(method.to_sym, url)
                              .with(headers: { 'X-API-Key' => 'api_key', 'X-Custom-Header' => 'custom-value' }) do |request|
          request.body.to_s == expected_body
        end.to_return(status: 200, body: response_data.to_json, headers: { 'X-Request-Id' => 'request-id' })

        result = client.call_adyen_api(
          'Checkout', { method: method, url: 'dispatch' }, request_data, { 'X-Custom-Header' => 'custom-value' }, '72'
        )

        expect(request_stub).to have_been_requested.once
        expect(result.status).to eq(200)
        expect(result.header['x-request-id']).to eq('request-id')
        expect(result.response).to eq(response_data)
        expect(result.response).to be_a Adyen::HashWithAccessors
        expect(result.response).to be_a_kind_of Hash
      end

      it "preserves connection failure handling for #{method.upcase}" do
        request_stub = WebMock.stub_request(method.to_sym, url).to_raise(Faraday::ConnectionFailed.new('original failure'))

        expect {
          client.call_adyen_api('Checkout', { method: method, url: 'dispatch' }, request_data, {}, '72')
        }.to raise_error(Faraday::ConnectionFailed, "Connection to #{url} failed")

        expect(request_stub).to have_been_requested.once
      end
    end

    %w[patch post].each do |method|
      it "sends JSON-string input without double encoding for #{method.upcase}" do
        request_stub = WebMock.stub_request(method.to_sym, url)
                              .with { |request| request.body == request_data.to_json }
                              .to_return(body: '{}')

        client.call_adyen_api('Checkout', { method: method, url: 'dispatch' }, request_data.to_json, {}, '72')

        expect(request_stub).to have_been_requested.once
      end
    end

    %i[hash json].each do |input_type|
      it "defaults legacy string actions to POST with #{input_type} input" do
        request_stub = WebMock.stub_request(:post, url)
                              .with { |request| request.body == request_data.to_json }
                              .to_return(body: response_data.to_json)
        input = input_type == :hash ? request_data : request_data.to_json

        result = client.call_adyen_api('Checkout', 'dispatch', input, {}, '72')

        expect(request_stub).to have_been_requested.once
        expect(result.response).to eq(response_data)
      end
    end

    it 'preserves connection failure handling for legacy string actions' do
      request_stub = WebMock.stub_request(:post, url).to_raise(Faraday::ConnectionFailed.new('original failure'))

      expect {
        client.call_adyen_api('Checkout', 'dispatch', request_data, {}, '72')
      }.to raise_error(Faraday::ConnectionFailed, "Connection to #{url} failed")

      expect(request_stub).to have_been_requested.once
    end
  end

  it 'creates Adyen client' do
    @shared_values[:client] = Adyen::Client.new
    expect(@shared_values[:client]).is_a? Adyen::Client
  end

  it 'sets env to :mock' do
    @shared_values[:client].env = :test
    expect(@shared_values[:client].env)
      .to eq(:test)
  end

  it 'raises ArgumentError when initialized with an invalid env string' do
    expect { Adyen::Client.new(env: 'live') }
      .to raise_error(ArgumentError)
  end

  it 'raises ArgumentError when initialized with an invalid env value' do
    expect { Adyen::Client.new(env: :invalid) }
      .to raise_error(ArgumentError)
  end

  it 'strips https:// from live_url_prefix when passed via constructor' do
    client = Adyen::Client.new(env: :live, live_url_prefix: 'https://myprefix')
    expect(client.service_url_base('Payment'))
      .to eq('https://myprefix-pal-live.adyenpayments.com/pal/servlet/Payment')
  end

  it 'does not mutate the original live_url_prefix string' do
    prefix = 'https://myprefix'
    Adyen::Client.new(env: :live, live_url_prefix: prefix)
    expect(prefix).to eq('https://myprefix')
  end

  it 'sets the version number' do
    @shared_values[:client].checkout.version = @shared_values[:version]
    expect(@shared_values[:client].checkout.version)
      .to eq(@shared_values[:version])
  end

  it 'fails payments call without WS user and password' do
    expect { @shared_values[:client].payment.payments_api.authorise('{}') }
      .to raise_error(Adyen::AuthenticationError)
    @shared_values[:client].ws_user = @shared_values[:ws_user]
    expect { @shared_values[:client].payment.payments_api.authorise('{}') }
      .to raise_error(Adyen::AuthenticationError)
  end

  it 'fails a checkout call without oauth token' do
    expect { @shared_values[:client].checkout.payments_api.payment_methods('{}') }.
      to raise_error(Adyen::AuthenticationError)
  end

  it 'fails a checkout call without api key' do
    expect { @shared_values[:client].checkout.payments_api.payment_methods('{}') }
      .to raise_error(Adyen::AuthenticationError)
    @shared_values[:client].api_key = 'api_key'
  end

  describe 'service name resolution' do
    let(:client) { Adyen::Client.new(env: :mock, mock_service_url_base: 'https://mock.test') }

    it 'is Checkout service when using checkout.payments_api' do
      expect(client.checkout.payments_api.service)
        .to eq('Checkout')
    end

    it 'is Checkout service when using checkout.recurring_api' do
      expect(client.checkout.recurring_api.service)
        .to eq('Checkout')
    end

    it 'is Recurring service when using recurring.recurring_api' do
      expect(client.recurring.recurring_api.service)
        .to eq('Recurring')
    end

    it 'is Payment service when using payment.payments_api' do
      expect(client.payment.payments_api.service)
        .to eq('Payment')
    end

    it 'is Payment service when using payment.modifications_api' do
      expect(client.payment.modifications_api.service)
        .to eq('Payment')
    end

    it 'is Payout service when using payout.instant_payouts_api' do
      expect(client.payout.instant_payouts_api.service)
        .to eq('Payout')
    end
  end

  it 'uses the specified mock service URL' do
    client = Adyen::Client.new(env: :mock, mock_service_url_base: 'https://mock.test')
    expect(client.service_url_base('Account'))
      .to eq('https://mock.test')
  end

  it 'generates localhost service URL when a mock port is specified' do
    client = Adyen::Client.new(env: :mock, mock_port: 3005)
    expect(client.service_url_base('Account'))
      .to eq('http://localhost:3005')
  end

  it 'prefers the mock service URL when both mock service URL and port are specified' do
    client = Adyen::Client.new(env: :mock, mock_port: 3005, mock_service_url_base: 'https://this-url-wins.test')
    expect(client.service_url_base('Account'))
      .to eq('https://this-url-wins.test')
  end

  it 'generates the correct service URL base for CAL TEST' do
    client = Adyen::Client.new(env: :test)
    client.live_url_prefix = 'abcdef1234567890-TestCompany'
    expect(client.service_url_base('Account'))
      .to eq('https://cal-test.adyen.com/cal/services/Account')
  end

  it 'generates the correct service URL base for CAL LIVE' do
    client = Adyen::Client.new(env: :live)
    client.live_url_prefix = 'abcdef1234567890-TestCompany'
    expect(client.service_url_base('Account'))
      .to eq('https://cal-live.adyen.com/cal/services/Account')
  end

  it 'generates the correct service URL base for PAL TEST' do
    client = Adyen::Client.new(env: :test)
    client.live_url_prefix = 'abcdef1234567890-TestCompany'
    expect(client.service_url_base('Payment'))
      .to eq('https://pal-test.adyen.com/pal/servlet/Payment')
  end

  it 'generates the correct service URL base for PAL LIVE' do
    client = Adyen::Client.new(env: :live)
    client.live_url_prefix = 'abcdef1234567890-TestCompany'
    expect(client.service_url_base('Payment'))
      .to eq('https://abcdef1234567890-TestCompany-pal-live.adyenpayments.com/pal/servlet/Payment')
  end

  it 'generates the correct service URL PAL authorise TEST' do
    client = Adyen::Client.new(env: :test)
    expect(client.service_url('Payment', 'authorise', '68'))
      .to eq('https://pal-test.adyen.com/pal/servlet/Payment/v68/authorise')
  end

  it 'generates the correct service URL base for PAL LIVE' do
    client = Adyen::Client.new(env: :live)
    client.live_url_prefix = 'abcdef1234567890-TestCompany'
    expect(client.service_url('Payment', 'authorise', '68'))
      .to eq('https://abcdef1234567890-TestCompany-pal-live.adyenpayments.com/pal/servlet/Payment/v68/authorise')
  end

  it 'generates a new set of ConnectionOptions when none are provided' do
    expect(Faraday::ConnectionOptions).to receive(:new).and_call_original
    Adyen::Client.new(env: :test)
  end

  it 'uses the ConnectionOptions provided' do
    connection_options = Faraday::ConnectionOptions.new
    expect(Faraday::ConnectionOptions).not_to receive(:new)
    Adyen::Client.new(env: :test, connection_options: connection_options)
  end

  it 'initiates a Faraday connection with the provided options' do
    connection_options = Faraday::ConnectionOptions.new(
      request: {
        open_timeout: 5,
        timeout: 10
      }
    )
    expect(Faraday::ConnectionOptions).not_to receive(:new)
    client = Adyen::Client.new(api_key: 'api_key', env: :mock, connection_options: connection_options)
    # verify custom options
    expect(client.connection_options[:request][:open_timeout]).to eq(5)
    expect(client.connection_options[:request][:timeout]).to eq(10)

    mock_faraday_connection = double(Faraday::Connection)
    client.service_url(@shared_values[:service], 'payments/details', client.checkout.version)
    request_body = JSON.parse(json_from_file('mocks/requests/Checkout/payment-details.json'))
    mock_response = Faraday::Response.new(status: 200)

    expect(Adyen::AdyenResult).to receive(:new)
    expect(Faraday).to receive(:new).with('http://localhost:3001/v72/payments/details',
                                          connection_options).and_return(mock_faraday_connection)
    expect(mock_faraday_connection).to receive(:post).and_return(mock_response)
    client.checkout.payments_api.payments_details(request_body)
  end

  it 'initiates a Faraday connection with the expected default timeouts' do
    client = Adyen::Client.new(env: :test)
    expect(client.connection_options[:request][:open_timeout]).to eq(30)
    expect(client.connection_options[:request][:timeout]).to eq(60)
  end

  it 'checks the creation of checkout url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('Checkout', 'paymentMethods', '71')).
      to eq('https://checkout-test.adyen.com/v71/paymentMethods')
  end

  it 'checks the creation of checkout url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :live, live_url_prefix: 'YourLiveUrlPrefix')
    expect(client.service_url('Checkout', 'paymentMethods', '71')).
      to eq('https://YourLiveUrlPrefix-checkout-live.adyenpayments.com/checkout/v71/paymentMethods')
  end
  it 'checks the creation of lem url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :live)
    expect(client.service_url('LegalEntityManagement', 'businessLines', '3')).
      to eq('https://kyc-live.adyen.com/lem/v3/businessLines')
  end

  it 'checks the creation of balancePlatform url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :live)
    expect(client.service_url('BalancePlatform', 'legalEntities', '1')).
      to eq('https://balanceplatform-api-live.adyen.com/bcl/v1/legalEntities')
  end

  it 'checks the creation of balancePlatform url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('BalancePlatform', 'legalEntities', '1')).
      to eq('https://balanceplatform-api-test.adyen.com/bcl/v1/legalEntities')
  end

  it 'checks the creation of transfers url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('Transfers', 'transactions', '1')).
      to eq('https://balanceplatform-api-test.adyen.com/btl/v1/transactions')
  end

  it 'checks the creation of management url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('Management', 'companies', '1')).
      to eq('https://management-test.adyen.com/v1/companies')
  end

  it 'checks the creation of binLookup url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('BinLookup', 'getCostEstimate', '54')).
      to eq('https://pal-test.adyen.com/pal/servlet/BinLookup/v54/getCostEstimate')
  end

  it 'check the creation of storedValue url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('StoredValue', 'issue', '46')).
      to eq('https://pal-test.adyen.com/pal/servlet/StoredValue/v46/issue')
  end

  it 'checks the creation of checkout url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :live, live_url_prefix: 'YourLiveUrlPrefix')
    expect(client.service_url('Checkout', 'paymentMethods', '70'))
      .to eq('https://YourLiveUrlPrefix-checkout-live.adyenpayments.com/checkout/v70/paymentMethods')
  end

  it 'checks the creation of lem url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :live)
    expect(client.service_url('LegalEntityManagement', 'businessLines', '3'))
      .to eq('https://kyc-live.adyen.com/lem/v3/businessLines')
  end

  it 'checks the creation of balancePlatform url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :live)
    expect(client.service_url('BalancePlatform', 'legalEntities', '1'))
      .to eq('https://balanceplatform-api-live.adyen.com/bcl/v1/legalEntities')
  end

  it 'checks the creation of balancePlatform url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('BalancePlatform', 'legalEntities', '1'))
      .to eq('https://balanceplatform-api-test.adyen.com/bcl/v1/legalEntities')
  end

  it 'checks the creation of transfers url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('Transfers', 'transactions', '1'))
      .to eq('https://balanceplatform-api-test.adyen.com/btl/v1/transactions')
  end

  it 'checks the creation of management url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('Management', 'companies', '1'))
      .to eq('https://management-test.adyen.com/v1/companies')
  end

  it 'checks the creation of binLookup url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('BinLookup', 'getCostEstimate', '54'))
      .to eq('https://pal-test.adyen.com/pal/servlet/BinLookup/v54/getCostEstimate')
  end

  it 'check the creation of storedValue url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('StoredValue', 'issue', '46'))
      .to eq('https://pal-test.adyen.com/pal/servlet/StoredValue/v46/issue')
  end

  it 'check the creation of payout url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('Payout', 'declineThirdParty', '68'))
      .to eq('https://pal-test.adyen.com/pal/servlet/Payout/v68/declineThirdParty')
  end

  it 'checks the creation of PosTerminalManagement url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('PosTerminalManagement', 'assignTerminals', '1'))
      .to eq('https://postfmapi-test.adyen.com/postfmapi/terminal/v1/assignTerminals')
  end

  it 'checks the creation of TerminalCloudAPI sync url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('TerminalCloudAPI', 'sync', nil))
      .to eq('https://terminal-api-test.adyen.com/sync')
  end

  it 'checks the creation of TerminalCloudAPI async url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('TerminalCloudAPI', 'async', nil))
      .to eq('https://terminal-api-test.adyen.com/async')
  end

  it 'checks the creation of TerminalCloudAPI connectedTerminals url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('TerminalCloudAPI', 'connectedTerminals', nil))
      .to eq('https://terminal-api-test.adyen.com/connectedTerminals')
  end

  it 'checks the initialization of the terminal region' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test, terminal_region: 'eu')
    expect(client.service_url('TerminalCloudAPI', 'connectedTerminals', nil))
      .to eq('https://terminal-api-test-eu.adyen.com/connectedTerminals')
  end

  it 'checks the initialization of the terminal region set to nil per default' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('TerminalCloudAPI', 'connectedTerminals', nil))
      .to eq('https://terminal-api-test.adyen.com/connectedTerminals')
  end

  it 'checks the creation of PosMobile sessions url' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    expect(client.service_url('PosMobile', 'sessions', nil))
      .to eq('https://checkout-test.adyen.com/checkout/possdk/sessions')
  end

  it 'correctly maps Disputes to DisputesService and generates valid URL' do
    client = Adyen::Client.new(env: :test)
    expect(client.service_url_base('Disputes'))
      .to eq('https://ca-test.adyen.com/ca/services/DisputeService')
  end

  it 'checks the creation of DataProtection url' do
    client = Adyen::Client.new(env: :test)
    expect(client.service_url_base('DataProtection'))
      .to eq('https://ca-test.adyen.com/ca/services/DataProtectionService')
  end

  it 'checks the creation of SessionAuthentication url for the test env' do
    client = Adyen::Client.new(env: :test)
    expect(client.service_url_base('SessionAuthentication'))
      .to eq('https://test.adyen.com/authe/api')
  end

  it 'checks the creation of SessionAuthentication url for the live env' do
    client = Adyen::Client.new(env: :live)
    expect(client.service_url_base('SessionAuthentication'))
      .to eq('https://authe-live.adyen.com/authe/api')
  end

   it 'checks the creation of Recurring API url for the test env' do
    client = Adyen::Client.new(env: :test)
    expect(client.service_url_base('Recurring'))
      .to eq('https://pal-test.adyen.com/pal/servlet/Recurring')
  end


  it 'raises FormatError on 400 response and checks content' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    mock_faraday_connection = double(Faraday::Connection)
    error_body = {
      status: 400,
      errorCode: '702',
      message: 'Structure of CreateCheckoutSessionRequest contains the following unknown fields: [paymentMethod]',
      errorType: 'validation'
    }
    mock_response = Faraday::Response.new(status: 400, body: error_body)

    allow(Faraday).to receive(:new).and_return(mock_faraday_connection)
    allow(mock_faraday_connection).to receive_message_chain(:headers, :[]=)
    allow(mock_faraday_connection).to receive(:post).and_return(mock_response)

    expect {
      client.checkout.payments_api.payments({})
    }.to raise_error(Adyen::FormatError) do |error|
      expect(error.code).to eq(400)
      expect(error.msg).to eq('Structure of CreateCheckoutSessionRequest contains the following unknown fields: [paymentMethod] ErrorCode: 702')
      expect(error.response[:errorCode]).to eq('702')
    end
  end

  it 'raises ValidationError on 422 response with RestServiceError (based on RFC 7807)' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    mock_faraday_connection = double(Faraday::Connection)
    error_body = {
      type: 'https://docs.adyen.com/errors/validation',
      title: 'The request is missing required fields or contains invalid data.',
      status: 422,
      detail: 'It is mandatory to specify a legalEntityId when creating a new account holder.',
      invalidFields: [{ 'name' => 'legalEntityId', 'message' => 'legalEntityId is not provided' }],
      errorCode: '30_011'
    }
    mock_response = Faraday::Response.new(status: 422, body: error_body)

    allow(Faraday).to receive(:new).and_return(mock_faraday_connection)
    allow(mock_faraday_connection).to receive_message_chain(:headers, :[]=)
    allow(mock_faraday_connection).to receive(:post).and_return(mock_response)

    expect {
      client.checkout.payments_api.payments({})
    }.to raise_error(Adyen::ValidationError) do |error|
      expect(error.code).to eq(422)
      expect(error.msg).to eq('It is mandatory to specify a legalEntityId when creating a new account holder. ErrorCode: 30_011')
      expect(error.response[:errorCode]).to eq('30_011')
      expect(error.response[:invalidFields]).to have_attributes(size: 1)
    end
  end

  it 'raises ValidationError on 422 response with ServiceError (legacy)' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    mock_faraday_connection = double(Faraday::Connection)
    error_body = {
      status: 422,
      errorCode: '14_030',
      message: 'Return URL is missing.',
      errorType: 'validation',
      pspReference: '8816118280275544'
    }
    mock_response = Faraday::Response.new(status: 422, body: error_body)

    allow(Faraday).to receive(:new).and_return(mock_faraday_connection)
    allow(mock_faraday_connection).to receive_message_chain(:headers, :[]=)
    allow(mock_faraday_connection).to receive(:post).and_return(mock_response)

    expect {
      client.checkout.payments_api.payments({})
    }.to raise_error(Adyen::ValidationError) do |error|
      expect(error.code).to eq(422)
      expect(error.msg).to eq('Return URL is missing. ErrorCode: 14_030')
      expect(error.response[:errorCode]).to eq('14_030')
    end
  end

  it 'raises ServerError on 500 response and checks content' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    mock_faraday_connection = double(Faraday::Connection)
    error_body = {
      status: 500,
      errorCode: '999',
      message: 'Unexpected error.',
      errorType: 'server error'
    }
    mock_response = Faraday::Response.new(status: 500, body: error_body)

    allow(Faraday).to receive(:new).and_return(mock_faraday_connection)
    allow(mock_faraday_connection).to receive_message_chain(:headers, :[]=)
    allow(mock_faraday_connection).to receive(:post).and_return(mock_response)

    expect {
      client.checkout.payments_api.payments({})
    }.to raise_error(Adyen::ServerError) do |error|
      expect(error.code).to eq(500)
      expect(error.msg).to eq('Unexpected error. ErrorCode: 999')
    end
  end

  it 'raises NotFoundError on 404 response and checks content' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    mock_faraday_connection = double(Faraday::Connection)
    error_body = '701 Version 71 is not supported, latest version: 68'
    mock_response = Faraday::Response.new(status: 404, body: error_body)

    allow(Faraday).to receive(:new).and_return(mock_faraday_connection)
    allow(mock_faraday_connection).to receive_message_chain(:headers, :[]=)
    allow(mock_faraday_connection).to receive(:post).and_return(mock_response)

    expect {
      client.checkout.payments_api.payments({})
    }.to raise_error(Adyen::NotFoundError) do |error|
      expect(error.code).to eq(404)
      expect(error.msg).to eq('Not found error')
    end
  end

  it 'raises NotFoundError on 404 response with an invalid JSON body' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    mock_faraday_connection = double(Faraday::Connection)
    error_body = 'this is an error message'
    mock_response = Faraday::Response.new(status: 404, body: error_body)

    allow(Faraday).to receive(:new).and_return(mock_faraday_connection)
    allow(mock_faraday_connection).to receive_message_chain(:headers, :[]=)
    allow(mock_faraday_connection).to receive(:post).and_return(mock_response)

    expect {
      client.payment.payments_api.authorise({})
    }.to raise_error(Adyen::NotFoundError) do |error|
      expect(error.code).to eq(404)
      expect(error.msg).to eq('Not found error')
    end
  end

  it 'ensures User-Agent is present in request headers' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test)
    mock_response = Faraday::Response.new(status: 200, body: '{}')

    mock_conn = instance_double(Faraday::Connection)
    expect(Faraday).to receive(:new).and_yield(mock_conn).and_return(mock_conn)
    allow(mock_conn).to receive(:adapter)
    connection_headers = {}
    allow(mock_conn).to receive(:headers).and_return(connection_headers)

    expect(mock_conn).to receive(:post) do |&block|
      mock_req = double('Faraday::Request')
      allow(mock_req).to receive(:body=)
      block.call(mock_req) if block_given?
      mock_response
    end.and_return(mock_response)

    client.checkout.payments_api.payments({})

    expect(connection_headers['User-Agent']).to_not be_nil
    expect(connection_headers['User-Agent']).to_not be_empty
    expect(connection_headers['User-Agent']).to eq("#{Adyen::NAME}/#{Adyen::VERSION}")
  end

  it 'ensures User-Agent includes application_name when provided' do
    client = Adyen::Client.new(api_key: 'api_key', env: :test, application_name: 'MyTestApp')
    mock_response = Faraday::Response.new(status: 200, body: '{}')

    mock_conn = instance_double(Faraday::Connection)
    expect(Faraday).to receive(:new).and_yield(mock_conn).and_return(mock_conn)
    allow(mock_conn).to receive(:adapter)
    connection_headers = {}
    allow(mock_conn).to receive(:headers).and_return(connection_headers)

    expect(mock_conn).to receive(:post) do |&block|
      mock_req = double('Faraday::Request')
      allow(mock_req).to receive(:body=)
      block.call(mock_req) if block_given?
      mock_response
    end.and_return(mock_response)

    client.checkout.payments_api.payments({})

    expect(connection_headers['User-Agent']).to_not be_nil
    expect(connection_headers['User-Agent']).to_not be_empty
    expect(connection_headers['User-Agent']).to eq("MyTestApp #{Adyen::NAME}/#{Adyen::VERSION}")
  end

  it 'ensures User-Agent includes application_name when set after initialization' do
    client = Adyen::Client.new
    client.api_key = 'api_key'
    client.env = :test
    client.application_name = 'MyTestAppAfterInit' # Set after initialization

    mock_response = Faraday::Response.new(status: 200, body: '{}')

    mock_conn = instance_double(Faraday::Connection)
    expect(Faraday).to receive(:new).and_yield(mock_conn).and_return(mock_conn)
    allow(mock_conn).to receive(:adapter)
    connection_headers = {}
    allow(mock_conn).to receive(:headers).and_return(connection_headers)

    expect(mock_conn).to receive(:post) do |&block|
      mock_req = double('Faraday::Request')
      allow(mock_req).to receive(:body=)
      block.call(mock_req) if block_given?
      mock_response
    end.and_return(mock_response)

    client.checkout.payments_api.payments({})

    expect(connection_headers['User-Agent']).to_not be_nil
    expect(connection_headers['User-Agent']).to_not be_empty
    expect(connection_headers['User-Agent']).to eq("MyTestAppAfterInit #{Adyen::NAME}/#{Adyen::VERSION}")
  end
end
