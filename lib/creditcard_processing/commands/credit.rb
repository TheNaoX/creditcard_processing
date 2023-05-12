# frozen_string_literal: true

module CreditcardProcessing
  module Commands
    class Credit
      attr_reader :card_name, :amount

      def initialize(card_name:, amount:)
        @card_name = card_name
        @amount = amount
      end

      def execute
        user = Storage::Users.instance.get_by(name: @card_name)

        credit_card = user.credit_card

        return if credit_card.nil?

        credit_card.credit(@amount)
      end
    end
  end
end
