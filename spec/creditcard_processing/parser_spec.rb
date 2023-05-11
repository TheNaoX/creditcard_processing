# frozen_string_literal: true

require 'spec_helper'

describe CreditcardProcessing::Parser do
  let(:input) { 'Add Tom 4111111111111111 $1000' }

  subject { described_class.new(input) }
  describe '#parse' do
    context 'when the input is correct' do
      it 'returns the proper values for the expected variables of each operation' do
        expect(subject.parse).to eq({
                                      operation: 'Add',
                                      card_name: 'Tom',
                                      card_number: '4111111111111111',
                                      amount: '$1000'
                                    })
      end
    end

    context 'when the input is incorrect' do
      let(:input) { 'this is an input that is incorrect for $1000 USD' }

      it 'the data for the operation is incomplete' do
        expect(subject.parse).to be_nil
      end
    end
  end
end
