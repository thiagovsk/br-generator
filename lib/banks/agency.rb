# Data for the agency numbers
class Agency
  attr_accessor :rule, :digits
  def initialize(rule = nil, digits = 4)
    @rule = rule
    @digits = digits
  end

  def agency_rule?
    !@rule.nil?
  end
end
