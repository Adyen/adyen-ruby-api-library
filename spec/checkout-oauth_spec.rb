require "spec_helper"
require "json"

# rubocop:disable Metrics/BlockLength
RSpec.describe "Adyen::Checkout OAuth authentication", service: "checkout" do
  before(:all) do
    @shared_values = {
      client: create_client(:oauth),
      service: "Checkout",
    }
    @auth_header = { "Authorization": "Bearer #{@shared_values[:client].oauth_token}"  }
  end

  # must be created manually because every field in the response is an array
  it "makes a payment_methods call", focus: true do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment_methods.json"))

    response_body = json_from_file("mocks/responses/Checkout/payment_methods.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentMethods", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.payments_api.payment_methods(request_body)
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

  it "makes a paymentMethods/balance call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment_methods_balance.json"))

    response_body = json_from_file("mocks/responses/Checkout/payment_methods_balance.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentMethods/balance", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.orders_api.get_balance_of_gift_card(request_body)
    # result.response is already a Ruby hash (rather than an unparsed JSON string)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["balance"]).
      to eq("100")
  end

  # must be created manually due to payments/details format
  it "makes a payments/details call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment-details.json"))

    response_body = json_from_file("mocks/responses/Checkout/payment-details.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/details", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.payments_api.payments_details(request_body)
    # result.response is already a Ruby hash (rather than an unparsed JSON string)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["resultCode"]).
      to eq("RedirectShopper")
    expect(response_hash.resultCode).
      to eq("RedirectShopper")
  end

  # must be created manually due to payments/result format
  it "makes a payments/result call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment-result.json"))

    response_body = json_from_file("mocks/responses/Checkout/payment-result.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/result", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.classic_checkout_sdk_api.verify_payment_result(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["resultCode"]).
      to eq("Authorised")
    expect(response_hash.resultCode).
      to eq("Authorised")
  end

  # must be created manually due to paymentsLinks format
  it "makes a paymentLinks call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment_links.json"))

    response_body = json_from_file("mocks/responses/Checkout/payment_links.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentLinks", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.payment_links_api.payment_links(request_body)
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

  # must be created manually due to paymentsLinks/{linkId} format
  it "makes a get paymentLinks/{linkId} call" do
    response_body = json_from_file("mocks/responses/Checkout/get-payment-link.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentLinks/1", @shared_values[:client].checkout.version)
    WebMock.stub_request(:get, url).
      with(
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.payment_links_api.get_payment_link("1")
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["status"]).
      to eq("active")
    expect(response_hash.id).
      to eq("MockId")
  end

  # must be created manually due to paymentsLinks/{linkId} format
  it "makes a patch paymentLinks/{linkId} call" do
    request_body = {
      :status => "expired",
    }

    response_body = json_from_file("mocks/responses/Checkout/update-payment-link.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "paymentLinks/1", @shared_values[:client].checkout.version)
    WebMock.stub_request(:patch, url).
      with(
        body: request_body,
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.payment_links_api.update_payment_link(request_body, "1")
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["status"]).
      to eq("expired")
    expect(response_hash.id).
      to eq("MockId")
  end

  it "makes an orders call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/orders.json"))

    response_body = json_from_file("mocks/responses/Checkout/orders.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "orders", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.orders_api.orders(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["remainingAmount"]["value"]).
      to eq(100)
  end

  it "makes an orders/cancel call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/orders_cancel.json"))

    response_body = json_from_file("mocks/responses/Checkout/orders_cancel.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "orders/cancel", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.orders_api.cancel_order(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["resultCode"]).
      to eq("cancelled")
  end

  it "makes an applePay/sessions call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/apple_pay_sessions.json"))

    response_body = json_from_file("mocks/responses/Checkout/apple_pay_sessions.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "applePay/sessions", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.utility_api.get_apple_pay_session(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["data"]).
      to eq("LARGE_BLOB_HERE")
  end

  it "makes a sessions call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/sessions.json"))

    response_body = json_from_file("mocks/responses/Checkout/sessions-success.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "sessions", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      )
      .to_return(body: response_body, status: 201)

    result = @shared_values[:client].checkout.payments_api.sessions(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(201)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
  end

  it "makes a capture call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/capture.json"))

    response_body = json_from_file("mocks/responses/Checkout/capture.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/12345/captures", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      )
      .to_return(body: response_body, status: 201)

    result = @shared_values[:client].checkout.modifications_api.capture_authorised_payment(request_body, "12345")
    response_hash = result.response

    expect(result.status).
      to eq(201)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash.reference).
      to eq("123456789")
    expect(response_hash.pspReference).
      to eq("12345")
  end

  it "makes a psp specific cancel call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/psp_cancel.json"))

    response_body = json_from_file("mocks/responses/Checkout/psp_cancel.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/12345/cancels", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      )
      .to_return(body: response_body, status: 201)

    result = @shared_values[:client].checkout.modifications_api.cancel_authorised_payment_by_psp_reference(request_body, "12345")
    response_hash = result.response

    expect(result.status).
      to eq(201)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash.reference).
      to eq("123456789")
    expect(response_hash.pspReference).
      to eq("12345")
  end

  it "makes a psp specific refunds call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/refund.json"))

    response_body = json_from_file("mocks/responses/Checkout/refund.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/12345/refunds", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      )
      .to_return(body: response_body, status: 201)

    result = @shared_values[:client].checkout.modifications_api.refund_captured_payment(request_body, "12345")
    response_hash = result.response

    expect(result.status).
      to eq(201)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash.reference).
      to eq("123456789")
    expect(response_hash.pspReference).
      to eq("12345")
  end

  it "makes a psp specific reversals call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/psp_cancel.json"))

    response_body = json_from_file("mocks/responses/Checkout/psp_cancel.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/12345/reversals", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      )
      .to_return(body: response_body, status: 201)

    result = @shared_values[:client].checkout.modifications_api.refund_or_cancel_payment(request_body, "12345")
    response_hash = result.response

    expect(result.status).
      to eq(201)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash.reference).
      to eq("123456789")
    expect(response_hash.pspReference).
      to eq("12345")
  end

  it "makes a psp specific amountUpdates call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/amount_updates.json"))

    response_body = json_from_file("mocks/responses/Checkout/amount_updates.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "payments/12345/amountUpdates", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      )
      .to_return(body: response_body, status: 201)

    result = @shared_values[:client].checkout.modifications_api.update_authorised_amount(request_body, "12345")
    response_hash = result.response

    expect(result.status).
      to eq(201)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash.reference).
      to eq("123456789")
    expect(response_hash.pspReference).
      to eq("12345")
  end

  it "makes a generic cancel call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/generic_cancel.json"))

    response_body = json_from_file("mocks/responses/Checkout/generic_cancel.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "cancels", @shared_values[:client].checkout.version)
    WebMock.stub_request(:post, url).
      with(
        body: request_body,
        headers: @auth_header
      )
      .to_return(body: response_body, status: 201)

    result = @shared_values[:client].checkout.modifications_api.cancel_authorised_payment(request_body)
    response_hash = result.response

    expect(result.status).
      to eq(201)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash.reference).
      to eq("123456789")
    expect(response_hash.pspReference).
      to eq("12345")
  end

  it "makes a get storedPaymentMethods call" do
    response_body = json_from_file("mocks/responses/Checkout/stored_payment_methods.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "storedPaymentMethods?merchantAccount=TestMerchantAccount&shopperReference=test-1234", @shared_values[:client].checkout.version)
    WebMock.stub_request(:get, url).
      with(
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.recurring_api.get_tokens_for_stored_payment_details(queryParams:{"merchantAccount" => "TestMerchantAccount", "shopperReference" => "test-1234"})
    response_hash = result.response

    expect(result.status).
      to eq(200)
    expect(response_hash).
      to eq(JSON.parse(response_body))
    expect(response_hash).
      to be_a Adyen::HashWithAccessors
    expect(response_hash).
      to be_a_kind_of Hash
    expect(response_hash["shopperReference"]).
      to eq("test-1234")
  end

  it "makes a delete storedPaymentMethods call" do

    url = @shared_values[:client].service_url(@shared_values[:service], "storedPaymentMethods/RL8FW7WZM6KXWD82?merchantAccount=TestMerchantAccount&shopperReference=test-1234", @shared_values[:client].checkout.version)
    WebMock.stub_request(:delete, url).
      with(
        headers: @auth_header
      ).
      to_return(
        body: "{}"
      )

    result = @shared_values[:client].checkout.recurring_api.delete_token_for_stored_payment_details("RL8FW7WZM6KXWD82", queryParams:{"merchantAccount" => "TestMerchantAccount", "shopperReference" => "test-1234"})
    response_hash = result.response

    expect(result.status).
      to eq(200)
  end

  it "tests sending the application headers" do
    response_body = json_from_file("mocks/responses/Checkout/stored_payment_methods.json")

    url = @shared_values[:client].service_url(@shared_values[:service], "storedPaymentMethods?merchantAccount=TestMerchantAccount&shopperReference=test-1234", @shared_values[:client].checkout.version)
    WebMock.stub_request(:get, url).
      with(
        headers: @auth_header
      ).
      to_return(
        body: response_body
      )

    result = @shared_values[:client].checkout.recurring_api.get_tokens_for_stored_payment_details(queryParams:{"merchantAccount" => "TestMerchantAccount", "shopperReference" => "test-1234"})
    expect(
    a_request(:get, "http://localhost:3001/v70/storedPaymentMethods?merchantAccount=TestMerchantAccount&shopperReference=test-1234")
      .with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Adyen-Library-Name'=>'adyen-ruby-api-library', 'Adyen-Library-Version'=>'7.0.1', 'Content-Type'=>'application/json', 'User-Agent'=>'adyen-ruby-api-library/7.0.1', 'Authorization'=>'Bearer oauth_token'})
    ).to have_been_made.once
  end

  # must be created manually because every field in the response is an array
  it "makes a LIVE paymentMethods call" do
    request_body = JSON.parse(json_from_file("mocks/requests/Checkout/payment_methods.json"))

    response_body = json_from_file("mocks/responses/Checkout/payment_methods.json")

    adyen = Adyen::Client.new
    adyen.api_key = 'AF5XXXXXXXXXXXXXXXXXXXX'
    adyen.env = :live
    adyen.live_url_prefix = "prefix"
    url = adyen.service_url("Checkout", "paymentMethods", @shared_values[:client].checkout.version)

    expect(url).
      to eq("https://prefix-checkout-live.adyenpayments.com/checkout/v70/paymentMethods")

  end
end

# rubocop:enable Metrics/BlockLength
