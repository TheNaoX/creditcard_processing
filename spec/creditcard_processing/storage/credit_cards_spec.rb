# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Storage::CreditCards do
  subject { described_class.instance }

  describe '.instance' do
    it 'returns an instance of the CreditCards repository' do
      expect(subject).to be_kind_of described_class
    end

    it 'is a singleton class' do
      expect(subject).to eq described_class.instance
    end
  end
end
