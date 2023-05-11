# frozen_string_literal: true

module CreditcardProcessing
  module Storage
    class CreditCards
      def self.instance
        @instance ||= new
      end

      private_class_method :new

      attr_reader :credit_cards

      def initialize
        @credit_cards = {}
      end

      def add(name:, number:, limit:)
        @credit_cards[name] ||= CreditCard.new(
          name: name,
          number: number,
          limit: limit
        )
      end

      def get_by(name:)
        @credit_cards[name]
      end
    end
  end
end
