# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Storage::Repositories::Accounts do
  subject { described_class.instance }

  describe '#add' do
    it 'adds a account by the name' do
      subject.add(name: 'Tom')

      expect(subject.accounts.keys).to eq ['Tom']
    end
  end

  describe '#get_by' do
    it 'retrieves the account by the name' do
      subject.add(name: 'Tom')

      expect(subject.get_by(name: 'Tom')).to be_a(CreditcardProcessing::Storage::Models::Account)
    end
  end
end
