# frozen_string_literal: true

module CreditcardProcessing
  class Parser
    COMMANDS_REGEX = /(\w+) (\w+) (\d+) (\$\w+)/

    def initialize(input)
      @input = input
    end

    def parse
      match_data = COMMANDS_REGEX.match(@input)

      return if match_data.nil?

      {
        command: match_data[1],
        card_name: match_data[2],
        card_number: match_data[3],
        amount: match_data[4]
      }
    end
  end
end
