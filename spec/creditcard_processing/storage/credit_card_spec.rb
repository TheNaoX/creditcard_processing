require 'spec_helper'

describe CreditcardProcessing::Storage::CreditCard do
  subject { described_class.new(**attributes) }

  let(:attributes) do
    {
      name: 'Tom',
      number: '4111111111111111',
      limit: 1000,
      balance: 0
    }
  end

  describe "#charge" do
    context "when the amount is lower than the limit" do
      it "changes the balance to the charged amount" do
        expect {
          subject.charge(200)
        }.to change(subject, :balance).from(0).to(200)
      end
    end

    context "when the amount is greater than the limit" do
      it "does not change the balance at all" do
        expect {
          subject.charge(1200)
        }.not_to change(subject, :balance)
      end
    end
  end
end
