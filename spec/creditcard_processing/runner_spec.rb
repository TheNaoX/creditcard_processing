# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Runner do
  subject { described_class.new(input) }

  let(:input) do
    <<~INPUT
      Add Tom 4111111111111111 $1000
      Add Lisa 5454545454545454 $3000
      Add Quincy 1234567890123456 $2000
      Charge Tom $500
      Charge Tom $800
      Charge Lisa $7
      Credit Lisa $100
      Credit Quincy $200
    INPUT
  end

  describe '#run' do
    it 'adds the associated entities with the transactions' do
      subject.run

      expect(CreditcardProcessing::Storage::Repositories::Accounts.instance.accounts.count).to eq 3

      # Quincy's credit card is not added because the number is invalid
      expect(CreditcardProcessing::Storage::Repositories::CreditCards.instance.credit_cards.count).to eq 2
    end

    context 'when some of the input is incorrect' do
      let(:input) do
        <<~INPUT
          Adds Tom 4111111111111111 $1000
          Add Lisa 5454545454545454 $3000
          Add Quincy 1234567890123456 $2000
          Charged Tom $500
          Charge Tom $800
          Charge Lisa $7
          Credit Lisa $100
          Credit Quincy $200
        INPUT
      end

      it 'only performs the correct commands without crashing' do
        subject.run

        expect(CreditcardProcessing::Storage::Repositories::Accounts.instance.accounts.count).to eq 2
      end
    end
  end
end
