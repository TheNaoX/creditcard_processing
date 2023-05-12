# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Storage::Models::Account do
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
        account = described_class.new(name: 'Tom')

        expect(account.credit_card).to be_a(CreditcardProcessing::Storage::Models::CreditCard)
      end
    end

    context 'when the credit_card does not exist' do
      it 'returns nil' do
        account = described_class.new(name: 'Quincy')

        expect(account.credit_card).to be_nil
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
        account = described_class.new(name: 'Tom')

        expect(account.balance).to eq 0
      end
    end

    context 'when the credit_card does not exist' do
      it 'returns "error"' do
        account = described_class.new(name: 'Quincy')

        expect(account.balance).to eq 'error'
      end
    end
  end
end
