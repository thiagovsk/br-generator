require_relative '../bank'

# Itau bank class
class Itau < Bank
  def initialize
    initialize_defaults
    create_agency
    create_account
    super('341', @agency, @account)
  end

  def initialize_defaults
    @modulo = 10
    initialize_account_defaults
  end

  def initialize_account_defaults
    @account_rule = Rule.new(build_account_rule_hash)
  end

  def build_account_rule_hash
    account_weight = [2, 1, 2, 1, 2, 1, 2, 1, 2]
    { bank: self, modulo: @modulo, weight: account_weight,
      after_modulo_rule: 'account_after_rule', sum_digits: true }
  end

  def create_agency
    @agency = Agency.new(nil)
  end

  def create_account
    @account = Account.new(@account_rule, 5, 5)
  end

  def account_after_rule(mod)
    mod == 10 ? '0' : (10 - mod).to_s
  end

  # Overrides bank methods
  def create_numbers
    agency = create_agency_numbers
    account = create_account_numbers(agency[:agency_number])
    { bank: @code }.merge(agency).merge(account)
  end

  def create_agency_numbers
    agency_number = @agency.agency_number
    { agency_number: agency_number }
  end

  def create_account_numbers(agency)
    account_number = @account.account_number
    account_check_digit = @account.account_check_digit(agency + account_number)
    { account_number: account_number,
      account_check_number: account_check_digit }
  end
end
