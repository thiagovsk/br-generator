require_relative '../bank'

# Generates a valid bank account from Bradesco
# Bank code: 237
# Agency digits: 4
# Account digits: 7
class Bradesco < Bank
  def initialize
    @agency_weights = [5, 4, 3, 2]
    @account_weights = [2, 7, 6, 5, 4, 3, 2]
    @code = '237'
    agency_rule = Rule.new(self, @agency_weights, 'agency_after_rule')
    @agency = Agency.new(agency_rule)
    @account = Account.new(7, 7)
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
    return 'P' if mod == 10
    mod.to_s
  end

  def account_after_rule(mod)
    return '0' if mod.zero?
    return 'P' if mod == 1
    (11 - mod).to_s
  end
end
