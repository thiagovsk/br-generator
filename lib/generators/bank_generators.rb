require_relative '../banks/bank'

require_relative '../banks/bank_information/banco_brasil.rb'
require_relative '../banks/bank_information/santander.rb'
require_relative '../banks/bank_information/bradesco.rb'
require_relative '../banks/bank_information/itau.rb'
require_relative '../banks/bank_information/hsbc.rb'
require_relative '../banks/bank_information/citibank.rb'

# Generates bank from code
module BankGenerator
  def generate_random_bank
    generate_bank(get_random_from_hash(Bank.banks))
  end

  def generate_bank(bank_code)
    bank = Object.const_get(Bank.bank(bank_code)).new
    bank.generate
  end
end
