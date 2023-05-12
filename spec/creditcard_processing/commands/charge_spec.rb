# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Commands::Charge do
  subject { described_class.new(**input) }

  let(:input) do
    {
      card_name: 'Tom',
      amount: 500
    }
  end

  let(:credit_card) do
    CreditcardProcessing::Storage::Repositories::CreditCards
      .instance
      .get_by(name: input[:card_name])
  end

  before do
    CreditcardProcessing::Commands::Add.new(
      card_name: 'Tom',
      card_number: '4111111111111111',
      limit: 1000
    ).execute
  end

  describe '#execute' do
    it 'adds the charge to the credit card' do
      expect do
        subject.execute
      end.to change(credit_card, :balance).from(0).to(500)
    end
  end
end
