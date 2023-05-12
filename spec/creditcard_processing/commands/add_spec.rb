# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Commands::Add do
  subject { described_class.new(**input) }

  let(:card_number) { '4111111111111111' }

  let(:input) do
    {
      card_name: 'Tom',
      card_number: card_number,
      limit: 1000
    }
  end

  let(:credit_cards_repo) { CreditcardProcessing::Storage::CreditCards.instance }

  describe '#execute' do
    it 'adds the credit card to the storage' do
      expect do
        subject.execute
      end.to change(credit_cards_repo.credit_cards, :count).by 1
    end

    context 'when the card is invalid' do
      let(:card_number) { '12345678' }

      it 'does not add the credit card to the storage' do
        expect do
          subject.execute
        end.not_to change(credit_cards_repo.credit_cards, :count)
      end
    end
  end
end
