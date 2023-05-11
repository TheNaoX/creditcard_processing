# frozen_string_literal: true

module CreditcardProcessing
  module Storage
    class CreditCard
      attr_reader :name, :number, :limit, :balance, :status

      def initialize(name:, number:, limit:, balance: 0, status: '')
        @name = name
        @number = number
        @limit = limit
        @balance = balance
        @status = status

        validate_card!
      end

      def charge(amount)
        return if @balance + amount > limit

        @balance += amount
      end

      def credit(amount)
        @balance -= amount
      end

      private

      def validate_card!
        return if valid_card?

        @status = 'Invalid Card'
        @limit = 0
      end

      def valid_card?
        CardValidator.new(@number).valid?
      end
    end
  end
end
