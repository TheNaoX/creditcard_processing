module CreditcardProcessing
  module Storage
    class CreditCards
      def self.instance
        @instance ||= new
      end

      private_class_method :new

      CreditCard = Struct.new(:name, :number, :limit, :balance)

      attr_reader :credit_cards

      def initialize
        @credit_cards = {}
      end

      def add(name:, number:, limit:)
        @credit_cards[name] ||= CreditCard.new(name, number, limit, 0)
      end
    end
  end
end
