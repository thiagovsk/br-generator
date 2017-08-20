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
    if mod == 10
      'P'
    elsif mod == 11
      '0'
    else
      mod.to_s
    end
  end

  def account_after_rule(mod)
    if mod.zero?
      '0'
    elsif mod == 1
      'P'
    else
      (11 - mod).to_s
    end
  end
end
