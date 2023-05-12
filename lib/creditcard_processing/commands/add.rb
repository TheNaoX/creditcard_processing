# frozen_string_literal: true

module CreditcardProcessing
  module Commands
    class Add
      attr_reader :card_name, :card_number, :limit

      def initialize(card_name:, card_number:, limit:)
        @card_name = card_name
        @card_number = card_number
        @limit = limit
      end

      def execute
        Storage::Repositories::Accounts.instance.add(name: @card_name)

        Storage::Repositories::CreditCards.instance.add(
          name: @card_name,
          number: @card_number,
          limit: @limit
        )
      rescue Storage::Models::CreditCard::Error => e
        ::CreditcardProcessing::Logger.info e.message

        false
      end
    end
  end
end
