require_relative '../errors/bank_errors'
# Data for the banks
class Bank
  attr_accessor :code, :agency, :account, :account_check, :bank_generator
  def generate
    @bank_util.generate
  end

  def generate_with_data(agency, account)
    @bank_util.generate_with_data(agency, account)
  end

  def self.banks
    {
      '001' => 'BancoDoBrasil',
      '033' => 'Santander',
      '237' => 'Bradesco',
      '341' => 'Itau',
      '399' => 'HSBC',
      '745' => 'Citibank'
    }
  end

  def self.bank(code)
    raise BankNotFoundError unless Bank.banks.key?(code)
    Bank.banks[code]
  end
end
