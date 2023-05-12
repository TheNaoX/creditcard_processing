# frozen_string_literal: true

require 'creditcard_processing/logger'
require 'creditcard_processing/generator'
require 'creditcard_processing/commands/add'
require 'creditcard_processing/commands/charge'
require 'creditcard_processing/commands/credit'
require 'creditcard_processing/storage/credit_cards'
require 'creditcard_processing/storage/accounts'
require 'creditcard_processing/storage/models/credit_card'
require 'creditcard_processing/storage/models/account'
require 'creditcard_processing/storage/validators/card_validator'
require 'creditcard_processing/runner'

module CreditcardProcessing
  module_function

  def run(input)
    runner = CreditcardProcessing::Runner.new(input)

    runner.run
  end

  def accounts
    CreditcardProcessing::Storage::Accounts.instance.accounts.sort
  end
end
