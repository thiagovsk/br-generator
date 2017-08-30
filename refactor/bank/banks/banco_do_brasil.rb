require_relative '../bank'

# Banco do Brasil bank class
class BancoDoBrasil < Bank
  def initialize
    initialize_defaults
    create_agency
    create_account
    super('001', @agency, @account)
  end

  def initialize_defaults
    @modulo = 11
    initialize_agency_defaults
    initialize_account_defaults
  end

  def initialize_agency_defaults
    @agency_rule = Rule.new(build_agency_rule_hash)
  end

  def build_agency_rule_hash
    agency_weight = [5, 4, 3, 2]
    { bank: self, modulo: @modulo, weight: agency_weight,
      after_modulo_rule: 'agency_after_rule' }
  end

  def initialize_account_defaults
    @account_rule = Rule.new(build_account_rule_hash)
  end

  def build_account_rule_hash
    account_weight = [9, 8, 7, 6, 5, 4, 3, 2]
    { bank: self, modulo: @modulo, weight: account_weight,
      after_modulo_rule: 'account_after_rule' }
  end

  def create_agency
    @agency = Agency.new(@agency_rule)
  end

  def create_account
    @account = Account.new(@account_rule, 4, 8)
  end

  def agency_after_rule(mod)
    mod = 11 - mod
    agency_mod(mod)
  end

  def agency_mod(mod)
    return '0' if mod == 11
    return 'X' if mod == 10
    mod.to_s
  end

  def account_after_rule(mod)
    agency_after_rule(mod)
  end
end
