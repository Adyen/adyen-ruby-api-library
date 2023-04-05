require_relative '../service'
module Adyen


  class BankAccountValidationApi < Service
    attr_accessor :service, :version

    def initialize(client, version = DEFAULT_VERSION)
      @service = "BalancePlatform"
      @client = client
      @version = version
    end

    def validate_bank_account_identification(request, headers: {} )
      """
      Validate a bank account
      """
      endpoint = "/validateBankAccountIdentification".gsub(/{.+?}/, '%s') 
      endpoint = endpoint.gsub(/^\//, "")
      endpoint = endpoint % []
      
      action = { method: "post", url: endpoint}
      @client.call_adyen_api(@service, action, request, headers, @version)
    end

  end
end
