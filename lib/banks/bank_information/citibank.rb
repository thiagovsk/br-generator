require_relative '../bank'

# Generates a valid bank account from Citibank
# Bank code: 745
# Agency digits: 4
# Account digits: 10
class Citibank < Bank
  def initialize
    @account_weights = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2]
    @code = '745'
    @agency = Agency.new
    @account = Account.new(10, 10)
    account_rule = Rule.new(self, @account_weights, 'account_after_rule')
    @account_check = AccountCheck.new(account_rule)
    @bank_util = BankUtil.new(self)
  end

  def account_after_rule(mod)
    mod > 1 ? (11 - mod).to_s : '0'
  end
end
