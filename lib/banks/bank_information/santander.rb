require_relative '../bank'

# Generates a valid bank account from Santander
# Bank code: 033
# Agency digits: 4
# Account digits: 6
class Santander < Bank
  def initialize
    @account_weights = [9, 7, 3, 1, 0, 0, 9, 7, 1, 3, 1, 9, 7, 3]
    @code = '033'
    @agency = Agency.new
    @account = Account.new(6, 6, '01')
    account_rule = Rule.new(self, @account_weights, 'account_after_rule')
                       .with_modulo(10).should_ignore_first_digit
    @account_check = AccountCheck.new(account_rule, true, '0001')
    @bank_util = BankUtil.new(self)
  end

  def account_after_rule(mod)
    mod = 10 - mod
    mod == 10 ? '0' : mod.to_s
  end
end
