# frozen_string_literal: true

module CreditcardProcessing
  module Storage
    module Models
      class Account
        attr_reader :name

        def initialize(name:)
          @name = name
        end

        def credit_card
          Repositories::CreditCards.instance.credit_cards[name]
        end

        def balance
          credit_card&.balance || 'error'
        end
      end
    end
  end
end
