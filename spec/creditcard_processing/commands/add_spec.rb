require 'spec_helper'

describe CreditcardProcessing::Commands::Add do
  subject { described_class.new(**input) }

  let(:input) do
    {
      card_name: 'Tom',
      card_number: '4111111111111111',
      limit: 1000,
    }
  end

  describe "#execute" do
    it "adds the creditcard to the storage" do
      expect {
        subject.execute
      }.to change(CreditcardProcessing::Storage::CreditCards.instance.credit_cards, :count).by 1
    end
  end
end
