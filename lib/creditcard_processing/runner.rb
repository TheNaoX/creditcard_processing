# frozen_string_literal: true

module CreditcardProcessing
  class Runner
    def initialize(input)
      @input = input
    end

    def run
      commands = generate_commands(@input)

      commands.map(&:execute)
    end

    def generate_commands(input)
      lines = input.split("\n")

      lines.map do |line|
        generator = CreditcardProcessing::Generator.new(line)

        generator.generate!
      end
    end
  end
end
