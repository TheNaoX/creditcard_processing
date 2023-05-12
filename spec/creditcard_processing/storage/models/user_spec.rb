# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Storage::Models::User do
  describe '#credit_card' do
    context 'when the credit_card exists' do
      before do
        CreditcardProcessing::Storage::CreditCards.instance.add(
          name: 'Tom',
          number: '4111111111111111',
          limit: 1000
        )
      end

      it 'pulls it from the repository' do
        user = described_class.new(name: 'Tom')

        expect(user.credit_card).to be_a(CreditcardProcessing::Storage::Models::CreditCard)
      end
    end

    context 'when the credit_card does not exist' do
      it 'returns nil' do
        user = described_class.new(name: 'Quincy')

        expect(user.credit_card).to be_nil
      end
    end
  end

  describe '#balance' do
    context 'when the credit_card exists' do
      before do
        CreditcardProcessing::Storage::CreditCards.instance.add(
          name: 'Tom',
          number: '4111111111111111',
          limit: 1000
        )
      end

      it 'returns a balance as an integer' do
        user = described_class.new(name: 'Tom')

        expect(user.balance).to eq 0
      end
    end

    context 'when the credit_card does not exist' do
      it 'returns "error"' do
        user = described_class.new(name: 'Quincy')

        expect(user.balance).to eq 'error'
      end
    end
  end
end
