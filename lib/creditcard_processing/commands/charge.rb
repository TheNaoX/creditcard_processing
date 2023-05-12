# frozen_string_literal: true

module CreditcardProcessing
  module Commands
    class Charge
      attr_reader :card_name, :amount

      def initialize(card_name:, amount:)
        @card_name = card_name
        @amount = amount
      end

      def execute
        account = Storage::Accounts.instance.get_by(name: @card_name)

        return if account.nil?

        credit_card = account.credit_card

        return if credit_card.nil?

        credit_card.charge(@amount)
      rescue Storage::Models::CreditCard::Error => e
        ::CreditcardProcessing::Logger.info e.message

        false
      end
    end
  end
end
