# frozen_string_literal: true

module CreditcardProcessing
  module Storage
    class User
      attr_reader :name

      def initialize(name:)
        @name = name
      end

      def credit_card
        CreditCards.instance.credit_cards[name]
      end
    end
  end
end
