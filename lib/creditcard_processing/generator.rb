# frozen_string_literal: true

module CreditcardProcessing
  class Generator
    DETECTION_REGEX = /^(\w+)/

    COMMANDS_REGEX = {
      add: /add (?<card_name>\w+) (?<card_number>\d+) \$(?<limit>\w+)/i,
      charge: /charge (?<card_name>\w+) \$(?<amount>\d+)/i,
      credit: /credit (?<card_name>\w+) \$(?<amount>\d+)/i
    }.freeze

    ALLOWED_COMMANDS = %w[add charge credit].freeze

    def initialize(input)
      @input = input
    end

    def generate!
      command = DETECTION_REGEX.match(@input)[1]
      command = command.downcase

      return unless ALLOWED_COMMANDS.include?(command)

      data = COMMANDS_REGEX[command.to_sym].match(@input)

      return if data.nil?

      command_klass_from(command).new(
        **symbolize_keys(data.named_captures)
      )
    end

    def command_klass_from(command_name)
      {
        add: Commands::Add,
        charge: Commands::Charge,
        credit: Commands::Credit
      }[command_name.to_sym]
    end

    def symbolize_keys(data)
      symbolized = {}

      numerical_keys = ['limit', 'amount']

      data.each do |key, value|
        symbolized[key.to_sym] = numerical_keys.include?(key) ? value.to_i : value
      end

      symbolized
    end
  end
end
