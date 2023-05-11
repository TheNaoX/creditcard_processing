# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Commands::Credit do
  subject { described_class.new(**input) }

  let(:initial_balance) { 300 }

  let(:input) do
    {
      card_name: 'Tom',
      amount: 130
    }
  end

  let(:credit_card) do
    CreditcardProcessing::Storage::CreditCards
      .instance
      .get_by(name: input[:card_name])
  end

  before do
    CreditcardProcessing::Storage::CreditCards
      .instance
      .add(
        name: 'Tom',
        number: '4111111111111111',
        limit: 1000
      )
  end

  describe '#execute' do
    it 'adds the credit to the credit card' do
      credit_card.charge(initial_balance)

      expect do
        subject.execute
      end.to change(credit_card, :balance).from(initial_balance).to(170)
    end
  end
end
