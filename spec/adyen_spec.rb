# require_relative "../lib/adyen"

RSpec.describe Adyen do
  before(:all) do
    @shared_values = {:client => nil}
  end

  it "has a version number" do
    expect(Adyen::VERSION).not_to be nil
  end

  it "creates Adyen client" do
    @shared_values[:client] = Adyen::Client.new
    expect(@shared_values[:client]).not_to be nil
    puts @shared_values[:client].inspect
  end

  it "executed Checkout.payments()" do
    puts @shared_values[:client].inspect
    expect(@shared_values[:client].checkout.payments({})).not_to be nil
  end

  it "executed Checkout.payments.details()" do
    puts @shared_values[:client].inspect
    expect(@shared_values[:client].checkout.payments.detail({})).not_to be nil
  end
end
