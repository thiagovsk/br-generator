require_relative '../data_class'

# Data for the account check number
class AccountCheck < DataClass
  def initialize(rule, include_agency = false, agency_ending = '')
    super({ rule: rule, include_agency: include_agency,
            agency_ending: agency_ending })
  end
end