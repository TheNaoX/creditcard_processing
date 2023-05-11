module CreditcardProcessing
  module Commands
    class Charge
      def initialize(card_name:, amount:)
        @card_name = card_name
        @amount = amount
      end

      def execute
        credit_card = Storage::CreditCards.instance.get_by(name: @card_name)

        credit_card.charge(@amount)
      end
    end
  end
end
