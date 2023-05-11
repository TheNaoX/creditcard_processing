# frozen_string_literal: true

module CreditcardProcessing
  module Storage
    class CreditCard
      attr_reader :name, :number, :limit, :balance

      def initialize(name:, number:, limit:, balance: 0)
        @name = name
        @number = number
        @limit = limit
        @balance = balance
      end

      def charge(amount)
        return if @balance + amount > limit

        @balance += amount
      end

      def credit(amount)
        @balance -= amount
      end
    end
  end
end
