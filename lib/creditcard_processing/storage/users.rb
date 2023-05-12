# frozen_string_literal: true

module CreditcardProcessing
  module Storage
    class Users
      def self.instance
        @instance ||= new
      end

      private_class_method :new

      attr_reader :users

      def initialize
        @users = {}
      end

      def add(name:)
        @users[name] ||= Models::User.new(name: name)
      end

      def get_by(name:)
        @users[name]
      end
    end
  end
end
