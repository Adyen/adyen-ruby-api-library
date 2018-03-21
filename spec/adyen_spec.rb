require "spec_helper"

RSpec.describe Adyen do
	before(:all) do
		@shared_values = { :client => nil }

	end

	it "has a version number" do
		expect(Adyen::VERSION).not_to be nil
	end

	it "creates Adyen client" do
		@shared_values[:client] = Adyen::Client.new
		expect(@shared_values[:client]).not_to be nil
	end

end
