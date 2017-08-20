require_relative '../bank'

# Generates a valid bank account from HSBC
# Bank code: 399
# Agency digits: 4
# Account digits: 6
class HSBC < Bank
  def initialize
    @account_weights = [8, 9, 2, 3, 4, 5, 6, 7, 8, 9]
    @code = '399'
    @agency = Agency.new
    @account = Account.new(6, 6)
    account_rule = Rule.new(self, @account_weights, 'account_after_rule')
    @account_check = AccountCheck.new(account_rule, true)
    @bank_util = BankUtil.new(self)
  end

  def account_after_rule(mod)
    mod.zero? || mod == 10 ? '0' : mod.to_s
  end
end
