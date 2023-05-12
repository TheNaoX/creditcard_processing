# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Storage::Users do
  subject { described_class.instance }

  describe '#add' do
    it 'adds a user by the name' do
      subject.add(name: 'Tom')

      expect(subject.users.keys).to eq ['Tom']
    end
  end

  describe '#get_by' do
    it 'retrieves the user by the name' do
      subject.add(name: 'Tom')

      expect(subject.get_by(name: 'Tom')).to be_a(CreditcardProcessing::Storage::Models::User)
    end
  end
end
