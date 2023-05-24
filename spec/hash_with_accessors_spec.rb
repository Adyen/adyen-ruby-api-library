# rubocop:disable Lint/ConstantDefinitionInBlock

require 'spec_helper'

RSpec.describe Adyen::HashWithAccessors do
  shared_examples :hash_with_accessors do
    subject do
      h = described_class.new
      h[key] = 1
      h
    end

    it 'returns values of a hashes' do
      expect(subject.arbitrary_accessor).to be 1
    end

    it 'can assign existing values' do
      subject.arbitrary_accessor = 2
      expect(subject.arbitrary_accessor).to be 2
      expect(subject[key]).to be 2
    end

    it 'complains if there are arguments for the accessor' do
      expect do
        subject.arbitrary_accessor(1)
      end.to raise_error(ArgumentError, 'wrong number of arguments (given 1, expected 0)')
      expect do
        subject.arbitrary_accessor(1, 2)
      end.to raise_error(ArgumentError, 'wrong number of arguments (given 2, expected 0)')
    end

    it 'complains if there are arguments for the accessor =' do
      # using send because i'm not sure how to do this wrong with normal ruby setter calling.
      # just here for completeness
      expect do
        subject.send(:arbitrary_accessor=)
      end.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)')
      expect do
        subject.send(:arbitrary_accessor=, 1,
                     2)
      end.to raise_error(ArgumentError, 'wrong number of arguments (given 2, expected 1)')
    end

    it 'responds to the accessor' do
      expect(subject).to respond_to(:arbitrary_accessor)
      expect(subject).to respond_to(:arbitrary_accessor=)
      expect(subject).to_not respond_to(:another_accessor)
      expect(subject).to_not respond_to(:another_accessor=)
    end

    it "raises when the key doesn't exist" do
      expect { subject.another_accessor }.to raise_error(NoMethodError)
      expect { subject.another_accessor = 1 }.to raise_error(NoMethodError)
    end
  end

  context 'with a string key' do
    let(:key) { 'arbitrary_accessor' }

    it_behaves_like :hash_with_accessors
  end

  context 'with a symbol key' do
    let(:key) { :arbitrary_accessor }

    it_behaves_like :hash_with_accessors
  end

  context 'with a conflicting key' do
    subject do
      h = described_class.new
      h['keys'] = 'not the keys'
      h
    end

    it "does original thing if there'd be a conflict" do
      expect(subject.keys).to eq ['keys'] # the default behaviour
      expect(subject['keys']).to eq 'not the keys'
    end

    it 'still does the writer thing even if the reader is defined' do
      subject.keys = 'written keys'
      expect(subject['keys']).to eq 'written keys'
      expect(subject.keys).to eq ['keys']
    end
  end

  context 'with some other method missing defined' do
    # this test setup is kind of janky,
    # but we want to confirm super is set up correctly
    # We could do a lot more house-keeping if we weren't sure Hash doesn't
    # define its own method_missing and respond_to_missing? by default,
    # and there was any particular reason to clean up properly and remove our
    # called_super method from Hash.

    before(:all) do
      class Hash
        def called_super(*args); end

        def method_missing(*args)
          called_super(:method_missing, *args)
          super
        end

        def respond_to_missing?(*args)
          called_super(:respond_to_missing?, *args)
          super
        end
      end
    end

    subject do
      h = described_class.new
      h[:my_accessor] = 1
      h
    end

    it 'can fall back to another respond_to_missing?' do
      expect(subject).to_not receive(:called_super).with(:respond_to_missing?, :my_accessor, false)
      expect(subject).to respond_to(:my_accessor)
      expect(subject).to receive(:called_super).with(:respond_to_missing?, :literally_anything, false)
      expect(subject.respond_to?(:literally_anything)).to be false
    end

    it 'can fall back to another method_missing' do
      expect(subject).to_not receive(:called_super).with(:method_missing, :my_accessor)
      expect(subject.my_accessor).to be 1
      expect(subject).to receive(:called_super).with(:method_missing, :something_else)
      expect { subject.something_else }.to raise_error(NoMethodError)
    end
  end

  it "doesn't modify all hashes" do
    expect { { a: 1 }.a }.to raise_error(NoMethodError)
  end
end
# rubocop:enable Lint/ConstantDefinitionInBlock
