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
  it 'makes an account_holder POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/create_account_holder.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/create_account_holder.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'accountHolders',
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.account_holders_api.create_account_holder(request_body)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes an account_holder PATCH call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/update_account_holder.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/update_account_holder.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'accountHolders/AH3227C223222C5GKR23686TF',
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:patch, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.account_holders_api.update_account_holder(
      request_body,
      'AH3227C223222C5GKR23686TF'
    )
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a balance_account GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_balance_account.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'balanceAccounts/BA3227C223222B5BLP6JQC3FD',
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.balance_accounts_api
                                    .get_balance_account('BA3227C223222B5BLP6JQC3FD')
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a balance_account/sweeps DELETE call' do
    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'balanceAccounts/balanceAccountID/sweeps/sweepID',
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:delete, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: '{}')

    result = @shared_values[:client].balance_platform.balance_accounts_api.delete_sweep('balanceAccountID', 'sweepID')
    result.response

    expect(result.status).to eq(200)
  end

  ## balancePlatform level transferLimits
  it 'makes a create_transfer_limit POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/create_transfer_limit.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/create_transfer_limit.json')
    balance_platform_id = 'YOUR_BALANCE_PLATFORM_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balancePlatforms/#{balance_platform_id}/transferLimits",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.transfer_limits_balance_platform_level_api
                   .create_transfer_limit(request_body, balance_platform_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_transfer_limits GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_transfer_limits.json')
    balance_platform_id = 'YOUR_BALANCE_PLATFORM_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balancePlatforms/#{balance_platform_id}/transferLimits",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.transfer_limits_balance_platform_level_api
                   .get_transfer_limits(balance_platform_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_specific_transfer_limit GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_specific_transfer_limit.json')
    balance_platform_id = 'YOUR_BALANCE_PLATFORM_ID'
    transfer_limit_id = 'YOUR_TRANSFER_LIMIT_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balancePlatforms/#{balance_platform_id}/transferLimits/#{transfer_limit_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.transfer_limits_balance_platform_level_api
                   .get_specific_transfer_limit(balance_platform_id, transfer_limit_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a delete_pending_transfer_limit DELETE call' do
    balance_platform_id = 'YOUR_BALANCE_PLATFORM_ID'
    transfer_limit_id = 'YOUR_TRANSFER_LIMIT_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balancePlatforms/#{balance_platform_id}/transferLimits/#{transfer_limit_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:delete, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(status: 204, body: '')

    result = @shared_values[:client].balance_platform.transfer_limits_balance_platform_level_api
                   .delete_pending_transfer_limit(balance_platform_id, transfer_limit_id)

    expect(result.status).to eq(204)
  end

  ## balanceAccount level transferLimits
  it 'makes a create_transfer_limit POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/create_transfer_limit.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/create_transfer_limit.json')
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/transferLimits",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.transfer_limits_balance_account_level_api
                   .create_transfer_limit(request_body, balance_account_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_transfer_limits GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_transfer_limits.json')
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/transferLimits",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.transfer_limits_balance_account_level_api
                   .get_transfer_limits(balance_account_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_specific_transfer_limit GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_specific_transfer_limit.json')
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'
    transfer_limit_id = 'YOUR_TRANSFER_LIMIT_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/transferLimits/#{transfer_limit_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.transfer_limits_balance_account_level_api
                   .get_specific_transfer_limit(balance_account_id, transfer_limit_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a delete_pending_transfer_limit DELETE call' do
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'
    transfer_limit_id = 'YOUR_TRANSFER_LIMIT_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/transferLimits/#{transfer_limit_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:delete, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(status: 204, body: '')

    result = @shared_values[:client].balance_platform.transfer_limits_balance_account_level_api
                   .delete_pending_transfer_limit(balance_account_id, transfer_limit_id)

    expect(result.status).to eq(204)
  end

  it 'makes an approve_pending_transfer_limits POST call' do
    request_body = ['TRLI00000000000000000000000001', 'TRLI00000000000000000000000002']
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/transferLimits/approve",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(status: 204, body: '')

    result = @shared_values[:client].balance_platform.transfer_limits_balance_account_level_api
                   .approve_pending_transfer_limits(request_body, balance_account_id)

    expect(result.status).to eq(204)
  end

  ## webhook settings
  it 'makes a create_webhook_setting POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/create_webhook_setting.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/create_webhook_setting.json')
    balance_platform_id = 'YOUR_BALANCE_PLATFORM_ID'
    webhook_id = 'YOUR_WEBHOOK_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balancePlatforms/#{balance_platform_id}/webhooks/#{webhook_id}/settings",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.balances_api
                   .create_webhook_setting(request_body, balance_platform_id, webhook_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a delete_webhook_setting DELETE call' do
    balance_platform_id = 'YOUR_BALANCE_PLATFORM_ID'
    webhook_id = 'YOUR_WEBHOOK_ID'
    setting_id = 'BWHS000000000000001'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balancePlatforms/#{balance_platform_id}/webhooks/#{webhook_id}/settings/#{setting_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:delete, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(status: 204, body: '')

    result = @shared_values[:client].balance_platform.balances_api
                   .delete_webhook_setting(balance_platform_id, webhook_id, setting_id)

    expect(result.status).to eq(204)
  end

  it 'makes a get_all_webhook_settings GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_all_webhook_settings.json')
    balance_platform_id = 'YOUR_BALANCE_PLATFORM_ID'
    webhook_id = 'YOUR_WEBHOOK_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balancePlatforms/#{balance_platform_id}/webhooks/#{webhook_id}/settings",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.balances_api
                   .get_all_webhook_settings(balance_platform_id, webhook_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  ## authorisedCardUsers
  it 'makes a get_all_authorised_card_users GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_all_authorised_card_users.json')
    payment_instrument_id = 'PI01234567890'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "paymentInstruments/#{payment_instrument_id}/authorisedCardUsers",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.authorized_card_users_api
                   .get_all_authorised_card_users(payment_instrument_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end
end
