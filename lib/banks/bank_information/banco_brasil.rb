require_relative '../bank'

# Generates a valid bank account from Banco do Brasil
# Bank code: 001
# Agency digits: 4
# Account digits: from 4 to 8
class BancoDoBrasil < Bank
  def initialize
    @agency_weights = [5, 4, 3, 2]
    @account_weights = [9, 8, 7, 6, 5, 4, 3, 2]
    @code = '001'
    agency_rule = Rule.new(self, @agency_weights, 'agency_after_rule')
    @agency = Agency.new(agency_rule)
    @account = Account.new(4, 8)
    account_rule = Rule.new(self, @account_weights, 'account_after_rule')
    @account_check = AccountCheck.new(account_rule)
    @bank_util = BankUtil.new(self)
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
