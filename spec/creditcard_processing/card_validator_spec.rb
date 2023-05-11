# frozen_string_literal: true

require 'spec_helper'

# FROM https://developer.paypal.com/tools/sandbox/card-testing/

CARD_NUMBERS = [
  '371449635398431',	# American Express
  '376680816376961',	# American Express
  '36259600000004',	# Diners Club
  '6304000000000000',	# Maestro
  '5063516945005047',	# Maestro
  '2223000048400011',	# Mastercard
  '4005519200000004',	# Visa
  '4012000033330026',	# Visa
  '4012000077777777',	# Visa
  '4012888888881881',	# Visa
  '4217651111111119',	# Visa
  '4500600000000061',	# Visa
  '4772129056533503',	# Visa
  '4915805038587737'	# Visa
].freeze

describe CreditcardProcessing::CardValidator do
  subject { described_class.new(card_number) }

  let(:card_number) { CARD_NUMBERS.sample }

  describe '#valid?' do
    context 'when using a valid credit card' do
      it 'is valid' do
        expect(subject.valid?).to be true
      end
    end

    context 'when using an invalid credit card' do
      let(:card_number) { '12312389987129898123908890' }

      it 'returns false' do
        expect(subject.valid?).to be false
      end
    end
  end
end
