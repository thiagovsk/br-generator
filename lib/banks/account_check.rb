# Data for the account check number
class AccountCheck
  attr_accessor :rule, :include_agency, :agency_ending
  def initialize(rule, include_agency = false, agency_ending = '')
    @rule = rule
    @include_agency = include_agency
    @agency_ending = agency_ending
  end

  def include_agency?
    @include_agency
  end
end
