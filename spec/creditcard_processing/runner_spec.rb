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

  describe "#run" do
    it "runs the the commands for the whole program" do
      subject.run

      expect(CreditcardProcessing::Storage::CreditCards.instance.credit_cards.count).to eq 3
    end
  end
end