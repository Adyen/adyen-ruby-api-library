generator:=ruby
openapi-generator-version:=6.4.0
openapi-generator-url:=https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/$(openapi-generator-version)/openapi-generator-cli-$(openapi-generator-version).jar
openapi-generator-jar:=build/openapi-generator-cli.jar
openapi-generator-cli:=java -jar build/openapi-generator-cli.jar
output:=build/out

services:=balancePlatform checkout legalEntityManagement management payout platformsAccount platformsFund platformsHostedOnboardingPage platformsNotificationConfiguration transfers
singleFileServices:=balanceControlService binLookup dataProtection recurring storedValue posTerminalManagement payment

binLookup: spec=BinLookupService-v54
checkout: spec=CheckoutService-v70
dataProtection: spec=DataProtectionService-v1
storedValue: spec=StoredValueService-v46
posTerminalManagement: spec=TfmAPIService-v1
payment: spec=PaymentService-v68
recurring: spec=RecurringService-v68
payout: spec=PayoutService-v68
management: spec=ManagementService-v1
legalEntityManagement: spec=LegalEntityService-v3
balancePlatform: spec=BalancePlatformService-v2
platformsAccount: spec=AccountService-v6
platformsFund: spec=FundService-v6
platformsNotificationConfiguration: spec=NotificationConfigurationService-v6
platformsHostedOnboardingPage: spec=HopService-v6
transfers: spec=TransferService-v3
balanceControlService: spec=BalanceControlService-v1

allServices: $(services) $(singleFileServices)

$(services): build/spec $(openapi-generator-jar)
	wget $(openapi-generator-url) -O build/openapi-generator-cli.jar
	rm -rf $(output)
	$(openapi-generator-cli) generate \
		-i build/spec/json/$(spec).json \
		-g $(generator) \
		-c ./templates/config.yaml \
		-o $(output) \
		--global-property apis,apiTests=false,apiDocs=false,supportingFiles=api-single.rb\
		--additional-properties serviceName=$@\
		--skip-validate-spec
	rm -f $(output)/lib/openapi_client/api/*-small.rb
	mkdir -p lib/adyen/services/$@
	mv $(output)/lib/openapi_client/api/*.rb lib/adyen/services/$@
	mv $(output)/api/api-single.rb lib/adyen/services/$@.rb
	rm -rf $(output)

$(singleFileServices): build/spec
	wget $(openapi-generator-url) -O build/openapi-generator-cli.jar
	cat <<< "$$(jq 'del(.paths[][].tags)' build/spec/json/$(spec).json)" > build/spec/json/$(spec).json
	rm -rf $(output)
	$(openapi-generator-cli) generate \
		-i build/spec/json/$(spec).json \
		-g $(generator) \
		-c ./templates/config.yaml \
		-o $(output) \
		--global-property apis,apiTests=false,apiDocs=false\
		--additional-properties serviceName=$@\
		--skip-validate-spec
	mv $(output)/lib/openapi_client/api/default_api-small.rb lib/adyen/services/$@.rb
	rm -rf $(output)

templates: $(openapi-generator-jar)
	$(openapi-generator-cli) author template -g $(generator) -o build/templates

# Download the generator
$(openapi-generator-jar):
	wget --quiet -o /dev/null $(openapi-generator-url) -O $(openapi-generator-jar)

build/spec:
	git clone https://github.com/Adyen/adyen-openapi.git build/spec
	perl -i -pe's/"openapi" : "3.[0-9].[0-9]"/"openapi" : "3.0.0"/' build/spec/json/*.json