# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Storage::Models::CreditCard do
  subject { described_class.new(**attributes) }

  let(:number) { '4111111111111111' }

  let(:attributes) do
    {
      name: 'Tom',
      number: number,
      limit: 1000,
      balance: 0
    }
  end

  describe '#initialize' do
    context 'when the card number is valid' do
      it 'creates a new credit card' do
        expect(subject).to be_a described_class
      end
    end

    context 'when the card number is invalid' do
      let(:number) { '12345678' }

      it 'raises an exception' do
        expect do
          subject
        end.to raise_error(CreditcardProcessing::Storage::Models::CreditCard::Error,
                           '12345678 is an invalid card number')
      end
    end
  end

  describe '#charge' do
    context 'when the amount is lower than the limit' do
      it 'changes the balance to the charged amount' do
        expect do
          subject.charge(200)
        end.to change(subject, :balance).from(0).to(200)
      end
    end

    context 'when the amount is greater than the limit' do
      it 'does not change the balance at all' do
        expect do
          subject.charge(1200)
        end.to raise_error(CreditcardProcessing::Storage::Models::CreditCard::Error,
                           'Declined transaction, card limit reached')
      end
    end
  end
end
