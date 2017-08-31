require_relative '../bank'

# HSBC bank class
class HSBC < Bank
  def initialize
    initialize_defaults
    create_agency
    create_account
    super('399', @agency, @account)
  end

  def initialize_defaults
    @modulo = 11
    initialize_account_defaults
  end

  def initialize_account_defaults
    @account_rule = Rule.new(build_account_rule_hash)
  end

  def build_account_rule_hash
    account_weight = [8, 9, 2, 3, 4, 5, 6, 7, 8, 9]
    { bank: self, modulo: @modulo, weight: account_weight,
    after_modulo_rule: 'account_after_rule' }
  end

  def create_agency
    @agency = Agency.new(nil)
  end

  def create_account
    @account = Account.new(@account_rule, 6, 6)
  end

  def account_after_rule(mod)
    mod.zero? || mod == 10 ? '0' : mod.to_s
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
