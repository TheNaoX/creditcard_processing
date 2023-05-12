# frozen_string_literal: true

module CreditcardProcessing
  module Storage
    module Validators
      class CardValidator
        def initialize(card_number)
          @card_number = card_number
        end

        def valid?
          digits = @card_number.chars.map(&:to_i)
          check = digits.pop

          sum = digits.reverse.each_slice(2).flat_map do |even, odd|
            [(even * 2).divmod(10), odd || 0]
          end.flatten.inject(:+)

          check.zero? ? (sum % 10).zero? : ((10 - sum) % 10) == check
        end
      end
    end
  end
end
