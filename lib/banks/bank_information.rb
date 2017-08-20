require_relative '../utils/rule'

require_relative 'bank_util'
require_relative 'bank'
require_relative 'agency'
require_relative 'account'
require_relative 'account_check'

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
    if mod == 11
      '0'
    elsif mod == 10
      'X'
    else
      mod.to_s
    end
  end

  def account_after_rule(mod)
    agency_after_rule(mod)
  end
end

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
