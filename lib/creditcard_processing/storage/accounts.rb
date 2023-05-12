# frozen_string_literal: true

module CreditcardProcessing
  module Storage
    class Accounts
      def self.instance
        @instance ||= new
      end

      private_class_method :new

      attr_reader :accounts

      def initialize
        @accounts = {}
      end

      def add(name:)
        @accounts[name] ||= Models::Account.new(name: name)
      end

      def get_by(name:)
        @accounts[name]
      end
    end
  end
end
