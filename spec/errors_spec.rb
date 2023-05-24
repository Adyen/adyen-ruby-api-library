# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Adyen::AdyenError do
  before(:all) do
    @shared_values = {
      request: {
        amount: {
          currency: 'USD',
          value: 1000
        },
        reference: 'Your order number',
        paymentMethod: {
          type: 'scheme',
          number: '4111111111111111',
          expiryMonth: '10',
          expiryYear: '2020',
          holderName: 'John Smith',
          cvc: '737'
        },
        returnUrl: 'https://your-company.com/',
        merchantAccount: 'YOUR_MERCHANT_ACCOUNT'
      }
    }
  end

  describe '#to_s' do
    it 'describes using the error properties' do
      expect(Adyen::AdyenError.new(
        @shared_values[:request],
        'response',
        'message',
        'code'
      ).to_s).to eq("Adyen::AdyenError code:code, msg:message, request:#{@shared_values[:request]}, response:response")
    end
    it 'skips the null properties' do
      expect(Adyen::AdyenError.new(
        @shared_values[:request],
        nil,
        nil,
        'code'
      ).to_s).to eq("Adyen::AdyenError code:code, request:#{@shared_values[:request]}")
    end
    it 'uses the proper error class name' do
      expect(Adyen::PermissionError.new(
        'message',
        @shared_values[:request],
        'response'
      ).to_s).to eq(
        "Adyen::PermissionError code:403, msg:message, request:#{@shared_values[:request]}, response:response"
      )
    end
  end
  describe '#masking' do
    it 'masks card number when logging request in errors' do
      expect(Adyen::AdyenError.new(@shared_values[:request], 'response', 'message',
                                   'code').request[:paymentMethod][:number]).to eq('411111******1111')
    end
    it 'masks CVC when logging request in errors' do
      expect(Adyen::AdyenError.new(@shared_values[:request], 'response', 'message',
                                   'code').request[:paymentMethod][:cvc]).to eq('***')
    end

    context 'when request is string' do
      it 'masks card number when logging request in errors' do
        expect(Adyen::AdyenError.new(JSON.generate(@shared_values[:request]), 'response', 'message',
                                     'code').request[:paymentMethod][:number]).to eq('411111******1111')
      end
      it 'masks CVC when logging request in errors' do
        expect(Adyen::AdyenError.new(JSON.generate(@shared_values[:request]), 'response', 'message',
                                     'code').request[:paymentMethod][:cvc]).to eq('***')
      end
    end
  end
end
