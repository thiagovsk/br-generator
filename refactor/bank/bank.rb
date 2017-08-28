require_relative '../data_class'

# Data for the banks
class Bank < DataClass
  def initialize(code, agency_rule, account, account_check)
    super({ code: code, agency_rule: agency_rule, account: account,
            account_check: account_check })
  end
end