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

INVALID_CARD_NUMBERS = %w[
  1234567890123456
  1234567890123457
  1234567890123458
  1234567890123459
  1234567890123450
  1234567890123451
].freeze

describe CreditcardProcessing::CardValidator do
  describe '#valid?' do
    context 'when using a valid credit card' do
      CARD_NUMBERS.each do |card_number|
        it "#{card_number} is valid" do
          subject = described_class.new(card_number)

          expect(subject.valid?).to be true
        end
      end
    end

    context 'when using an invalid credit card' do
      INVALID_CARD_NUMBERS.each do |card_number|
        it 'returns false' do
          subject = described_class.new(card_number)

          expect(subject.valid?).to be false
        end
      end
    end
  end
end
