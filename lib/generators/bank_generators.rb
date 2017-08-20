require_relative '../banks/bank_information'
require_relative '../banks/bank'

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
