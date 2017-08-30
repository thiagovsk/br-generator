# Errors
require_relative 'bank_errors'

# Other
require_relative '../rule'
require_relative 'agency'
require_relative 'account'

# Data for the banks
class Bank
  def initialize(code, agency, account)
    @code = code
    @agency = agency
    @account = account
  end
  
  def self.by_code(code)
    ObjectSpace.each_object do |o|
      return o if o.code == code
    end
    raise BankNotFoundError
  end

  def create_numbers
    agency = create_agency_numbers
    account = create_account_numbers
    { bank: @code }.merge(agency).merge(account)
  end

  def create_agency_numbers
    agency_number = @agency.agency_number
    agency_check_digit = @agency.agency_check_digit(agency_number)
    { agency_number: agency_number, agency_check_number: agency_check_digit }
  end

  def create_account_numbers
    account_number = @account.account_number
    account_check_digit = @account.account_check_digit(account_number)
    { account_number: account_number,
      account_check_number: account_check_digit }
  end
end
