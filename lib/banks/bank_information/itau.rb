require_relative '../bank'

# Generates a valid bank account from Itau
# Bank code: 341
# Agency digits: 4
# Account digits: 5
class Itau < Bank
  def initialize
    @account_weights = [2, 1, 2, 1, 2, 1, 2, 1, 2]
    @code = '341'
    @agency = Agency.new
    @account = Account.new(5, 5)
    account_rule = Rule.new(self, @account_weights, 'account_after_rule')
                       .with_modulo(10).should_sum_digits
    @account_check = AccountCheck.new(account_rule, true)
    @bank_util = BankUtil.new(self)
  end

  def account_after_rule(mod)
    mod == 10 ? '0' : (10 - mod).to_s
  end
end
