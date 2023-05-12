# frozen_string_literal: true

module CreditcardProcessing
  module Storage
    module Models
      class CreditCard
        attr_reader :name, :number, :limit, :balance

        class Error < StandardError; end

        def initialize(name:, number:, limit:, balance: 0)
          @name = name
          @number = number
          @limit = limit
          @balance = balance

          validate_card!
        end

        def charge(amount)
          raise Error, 'Declined transaction, card limit reached' if @balance + amount > limit

          @balance += amount
        end

        def credit(amount)
          @balance -= amount
        end

        private

        def validate_card!
          raise Error, "#{@number} is an invalid card number" unless valid_card?
        end

        def valid_card?
          CardValidator.new(@number).valid?
        end
      end
    end
  end
end
