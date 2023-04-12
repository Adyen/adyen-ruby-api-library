generator:=ruby
openapi-generator-version:=6.4.0
openapi-generator-url:=https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/$(openapi-generator-version)/openapi-generator-cli-$(openapi-generator-version).jar
openapi-generator-cli:=java -jar build/openapi-generator-cli.jar
services:=balancePlatform checkout legalEntityManagement management payments payouts platformsAccount platformsFund platformsHostedOnboardingPage platformsNotificationConfiguration transfers
singleFileServices:=balanceControlService binLookup dataProtection recurring storedValue terminal

binLookup: spec=BinLookupService-v52
checkout: spec=CheckoutService-v70
dataProtection: spec=DataProtectionService-v1
storedValue: spec=StoredValueService-v46
terminal: spec=TfmAPIService-v1
payments: spec=PaymentService-v68
recurring: spec=RecurringService-v68
payouts: spec=PayoutService-v68
management: spec=ManagementService-v1
legalEntityManagement: spec=LegalEntityService-v2
balancePlatform: spec=BalancePlatformService-v2
platformsAccount: spec=AccountService-v6
platformsFund: spec=FundService-v6
platformsNotificationConfiguration: spec=NotificationConfigurationService-v6
platformsHostedOnboardingPage: spec=HopService-v6
transfers: spec=TransferService-v3
balanceControlService: spec=BalanceControlService-v1

$(services): build/spec
	wget $(openapi-generator-url) -O build/openapi-generator-cli.jar
	rm -rf lib/adyen/services/$@
	$(openapi-generator-cli) generate \
		-i build/spec/json/$(spec).json \
		-g $(generator) \
		-c ./templates/config.yaml \
		-o build \
		--global-property apis,apiTests=false,apiDocs=false,supportingFiles=api-single.rb\
		--additional-properties serviceName=$@\
		--skip-validate-spec
	cp -r build/lib/openapi_client/api lib/adyen/services/$@
	cp build/api/api-single.rb lib/adyen/services/$@.rb
	rm -rf build

$(singleFileServices): build/spec
	wget https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/6.0.1/openapi-generator-cli-6.0.1.jar -O build/openapi-generator-cli.jar
	rm -rf lib/adyen/services/$@.rb
	$(openapi-generator-cli) generate \
		-i build/spec/json/$(spec).json \
		-g $(generator) \
		-c ./templates/config.yaml \
		-o build \
		--global-property apis,apiTests=false,apiDocs=false\
		--additional-properties serviceName=$@\
		--skip-validate-spec
	cp build/lib/openapi_client/api/general_api-small.rb lib/adyen/services/$@.rb
	rm -rf build



build/spec:
	git clone https://github.com/Adyen/adyen-openapi.git build/spec
	perl -i -pe's/"openapi" : "3.[0-9].[0-9]"/"openapi" : "3.0.0"/' build/spec/json/*.json