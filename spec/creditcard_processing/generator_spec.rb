# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Generator do
  subject { described_class.new(input) }

  let(:input) { '' }

  context '#generate!' do
    context 'when it is a known command' do
      context 'and the command is Add' do
        let(:input) { 'Add Tom 4111111111111111 $1000' }

        it 'returns the command successfully' do
          command = subject.generate!

          expect(command).to be_kind_of CreditcardProcessing::Commands::Add
          expect(command.card_name).to eq 'Tom'
          expect(command.card_number).to eq '4111111111111111'
          expect(command.limit).to eq 1000
        end
      end

      context 'and the command is Charge' do
        let(:input) { 'Charge Tom $1000' }

        it 'returns the command successfully' do
          command = subject.generate!

          expect(command).to be_kind_of CreditcardProcessing::Commands::Charge
          expect(command.card_name).to eq 'Tom'
          expect(command.amount).to eq 1000
        end
      end

      context 'and the command is Credit' do
        let(:input) { 'Credit Tom $1000' }

        it 'returns the command successfully' do
          command = subject.generate!

          expect(command).to be_kind_of CreditcardProcessing::Commands::Credit
          expect(command.card_name).to eq 'Tom'
          expect(command.amount).to eq 1000
        end
      end

      context 'but the arguments are incorrect' do
        let(:input) { 'Credit Tom the amount of $1000' }

        it 'returns nil' do
          command = subject.generate!

          expect(command).to be_nil
        end
      end
    end

    context "when it's an unknown command" do
      let(:input) { 'Charged Tom $1000' }

      it 'returns nil' do
        command = subject.generate!

        expect(command).to be_nil
      end
    end
  end
end
