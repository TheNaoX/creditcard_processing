# frozen_string_literal: true

module CreditcardProcessing
  module Commands
    class Add
      def initialize(card_name:, card_number:, limit:)
        @card_name = card_name
        @card_number = card_number
        @limit = limit
      end

      def execute
        Storage::CreditCards.instance.add(
          name: @card_name,
          number: @card_number,
          limit: @limit
        )
      end
    end
  end
end
