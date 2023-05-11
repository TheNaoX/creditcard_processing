module CreditcardProcessing
  class Parser
    OPERATION_REGEX = /(\w+) (\w+) (\d+) (\$\w+)/

    def initialize(input)
      @input = input
    end

    def parse
      match_data = OPERATION_REGEX.match(@input)

      return if match_data.nil?

      {
        operation: match_data[1],
        card_name: match_data[2],
        card_number: match_data[3],
        amount: match_data[4]
      }
    end
  end
end
