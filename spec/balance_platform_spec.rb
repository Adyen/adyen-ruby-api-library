require 'spec_helper'
require 'json'

RSpec.describe Adyen::BalancePlatform, service: 'balancePlatform' do
  SWEEPS_ENDPOINT = 'balanceAccounts/balanceAccountID/sweeps/sweepID'

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
      SWEEPS_ENDPOINT,
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:delete, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(status: 204, body: '')

    result = @shared_values[:client].balance_platform.custom_payout_schedules_sweeps_api.delete_sweep('balanceAccountID', 'sweepID')

    expect(result.status).to eq(204)
  end

  it 'makes a create_sweep POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/create_sweep.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/create_sweep.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'balanceAccounts/balanceAccountID/sweeps',
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.custom_payout_schedules_sweeps_api.create_sweep(request_body, 'balanceAccountID')
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_all_sweeps_for_balance_account GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_all_sweeps_for_balance_account.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'balanceAccounts/balanceAccountID/sweeps',
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(
             query: { 'limit' => 5, 'offset' => 10 },
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.custom_payout_schedules_sweeps_api
                   .get_all_sweeps_for_balance_account('balanceAccountID', query_params: { 'limit' => 5, 'offset' => 10 })
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_sweep GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_sweep.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      SWEEPS_ENDPOINT,
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.custom_payout_schedules_sweeps_api.get_sweep('balanceAccountID', 'sweepID')
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes an update_sweep PATCH call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/update_sweep.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/update_sweep.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      SWEEPS_ENDPOINT,
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:patch, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.custom_payout_schedules_sweeps_api.update_sweep(request_body, 'balanceAccountID', 'sweepID')
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
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

  it 'makes a get_tax_form_summary GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_tax_form_summary.json')
    account_holder_id = 'AH3227C223222C5GKR23686TF'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "accountHolders/#{account_holder_id}/taxFormSummary",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.account_holders_api
                                    .get_tax_form_summary(account_holder_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  ## directDebitMandates
  it 'makes a get_list_of_mandates GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_list_of_mandates.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'mandates',
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.direct_debit_mandates_api.get_list_of_mandates
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_mandate_by_id GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_mandate_by_id.json')
    mandate_id = 'MNDT7QXPLKT9R333640TX334709E'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "mandates/#{mandate_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.direct_debit_mandates_api.get_mandate_by_id(mandate_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a cancel_mandate POST call' do
    mandate_id = 'MNDT7QXPLKT9R333640TX334709E'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "mandates/#{mandate_id}/cancel",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(status: 202, body: '')

    result = @shared_values[:client].balance_platform.direct_debit_mandates_api.cancel_mandate(mandate_id)

    expect(result.status).to eq(202)
  end

  it 'makes an update_mandate PATCH call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/update_mandate.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/get_mandate_by_id.json')
    mandate_id = 'MNDT7QXPLKT9R333640TX334709E'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "mandates/#{mandate_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:patch, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.direct_debit_mandates_api
                                    .update_mandate(request_body, mandate_id)
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

  ## managed payout schedules
  it 'makes an apply_managed_schedule POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/apply_managed_schedule.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/apply_managed_schedule.json')
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/payoutSchedules",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.managed_payout_schedules_api
                   .apply_managed_schedule(request_body, balance_account_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_balance_account_managed_schedules GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_balance_account_managed_schedules.json')
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/payoutSchedules",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.managed_payout_schedules_api
                   .get_balance_account_managed_schedules(balance_account_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_balance_account_managed_schedule_by_id GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_balance_account_managed_schedule_by_id.json')
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'
    payout_schedule_id = 'PSAC00000000000000000000000001'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/payoutSchedules/#{payout_schedule_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.managed_payout_schedules_api
                   .get_balance_account_managed_schedule_by_id(balance_account_id, payout_schedule_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes an update_balance_account_managed_schedule PATCH call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/update_balance_account_managed_schedule.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/update_balance_account_managed_schedule.json')
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'
    payout_schedule_id = 'PSAC00000000000000000000000001'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/payoutSchedules/#{payout_schedule_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:patch, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.managed_payout_schedules_api
                   .update_balance_account_managed_schedule(request_body, balance_account_id, payout_schedule_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a delete_balance_account_managed_schedule DELETE call' do
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'
    payout_schedule_id = 'PSAC00000000000000000000000001'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/payoutSchedules/#{payout_schedule_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:delete, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(status: 204, body: '')

    result = @shared_values[:client].balance_platform.managed_payout_schedules_api
                   .delete_balance_account_managed_schedule(balance_account_id, payout_schedule_id)

    expect(result.status).to eq(204)
  end

  it 'makes a get_payout_schedule_executions GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_payout_schedule_executions.json')
    balance_account_id = 'YOUR_BALANCE_ACCOUNT_ID'
    payout_schedule_id = 'PSAC00000000000000000000000001'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/payoutSchedules/#{payout_schedule_id}/executions",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(
             query: { 'results' => 'succeeded,failed', 'offset' => 0 },
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.managed_payout_schedules_api
                   .get_payout_schedule_executions(
                     balance_account_id,
                     payout_schedule_id,
                     query_params: { 'results' => 'succeeded,failed', 'offset' => 0 }
                   )
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_balance_platform_managed_schedules GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_balance_platform_managed_schedules.json')
    balance_platform_id = 'YOUR_BALANCE_PLATFORM_ID'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balancePlatforms/#{balance_platform_id}/payoutSchedules",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.managed_payout_schedules_api
                   .get_balance_platform_managed_schedules(balance_platform_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_balance_platform_managed_schedule_by_id GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_balance_platform_managed_schedule_by_id.json')
    balance_platform_id = 'YOUR_BALANCE_PLATFORM_ID'
    payout_schedule_id = 'PSPC00000000000000000000000001'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balancePlatforms/#{balance_platform_id}/payoutSchedules/#{payout_schedule_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.managed_payout_schedules_api
                   .get_balance_platform_managed_schedule_by_id(balance_platform_id, payout_schedule_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  ## recurringTopUps
  it 'makes a create_recurring_top_up POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/create_recurring_top_up.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/create_recurring_top_up.json')
    balance_account_id = 'BA3227C223222B5BLP6JQC3FD'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/recurringTopUps",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.recurring_top_ups_api
                                    .create_recurring_top_up(request_body, balance_account_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a get_recurring_top_ups GET call' do
    response_body = json_from_file('mocks/responses/BalancePlatform/get_recurring_top_ups.json')
    balance_account_id = 'BA3227C223222B5BLP6JQC3FD'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/recurringTopUps",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:get, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.recurring_top_ups_api
                                    .get_recurring_top_ups(balance_account_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes an update_recurring_top_ups PATCH call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/update_recurring_top_ups.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/update_recurring_top_ups.json')
    balance_account_id = 'BA3227C223222B5BLP6JQC3FD'
    top_up_id = 'TUPC0000000000000000000001'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/recurringTopUps/#{top_up_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:patch, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.recurring_top_ups_api
                                    .update_recurring_top_ups(request_body, balance_account_id, top_up_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a delete_recurring_top_up DELETE call' do
    balance_account_id = 'BA3227C223222B5BLP6JQC3FD'
    top_up_id = 'TUPC0000000000000000000001'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "balanceAccounts/#{balance_account_id}/recurringTopUps/#{top_up_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:delete, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(status: 204, body: '')

    result = @shared_values[:client].balance_platform.recurring_top_ups_api
                                    .delete_recurring_top_up(balance_account_id, top_up_id)

    expect(result.status).to eq(204)
  end

  ## scaDeviceManagement
  it 'makes a begin_sca_device_registration POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/begin_sca_device_registration.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/begin_sca_device_registration.json')

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      'scaDevices',
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(status: 201, body: response_body)

    result = @shared_values[:client].balance_platform.sca_device_management_api
                                    .begin_sca_device_registration(request_body)
    response_hash = result.response

    expect(result.status).to eq(201)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a delete_sca_device DELETE call' do
    device_id = 'BSDR42XV3223223S5N6CDQDGH53M8H'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "scaDevices/#{device_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:delete, url)
           .with(headers: { 'x-api-key' => @shared_values[:client].api_key })
           .to_return(status: 204, body: '')

    result = @shared_values[:client].balance_platform.sca_device_management_api
                                    .delete_sca_device(device_id)

    expect(result.status).to eq(204)
  end

  it 'makes a finish_sca_device_registration PATCH call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/finish_sca_device_registration.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/finish_sca_device_registration.json')
    device_id = 'BSDR42XV3223223S5N6CDQDGH53M8H'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "scaDevices/#{device_id}",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:patch, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(body: response_body)

    result = @shared_values[:client].balance_platform.sca_device_management_api
                                    .finish_sca_device_registration(request_body, device_id)
    response_hash = result.response

    expect(result.status).to eq(200)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end

  it 'makes a submit_sca_association POST call' do
    request_body = JSON.parse(json_from_file('mocks/requests/BalancePlatform/submit_sca_association.json'))
    response_body = json_from_file('mocks/responses/BalancePlatform/submit_sca_association.json')
    device_id = 'BSDR42XV3223223S5N6CDQDGH53M8H'

    url = @shared_values[:client].service_url(
      @shared_values[:service],
      "scaDevices/#{device_id}/scaAssociations",
      @shared_values[:client].balance_platform.version
    )
    WebMock.stub_request(:post, url)
           .with(
             body: request_body,
             headers: { 'x-api-key' => @shared_values[:client].api_key }
           )
           .to_return(status: 201, body: response_body)

    result = @shared_values[:client].balance_platform.sca_device_management_api
                                    .submit_sca_association(request_body, device_id)
    response_hash = result.response

    expect(result.status).to eq(201)
    expect(response_hash).to eq(JSON.parse(response_body))
    expect(response_hash).to be_a Adyen::HashWithAccessors
    expect(response_hash).to be_a_kind_of Hash
  end
end
