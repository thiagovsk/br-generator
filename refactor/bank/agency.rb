# Helpers
require_relative '../helpers/random_helper'

include RandomHelper

# Data for the agency number
class Agency
  def initialize(rule, digits = 4)
    @rule = rule
    @digits = digits
  end

  def agency_number
    generate_number_len(@digits)
  end

  def agency_check_digit(number)
    @rule.execute(number)
  end
end
