# frozen_string_literal: true

module CreditcardProcessing
  module Commands
    class Credit
      def initialize(card_name:, amount:)
        @card_name = card_name
        @amount = amount
      end

      def execute
        credit_card = Storage::CreditCards.instance.get_by(name: @card_name)

        credit_card.credit(@amount)
      end
    end
  end
end
