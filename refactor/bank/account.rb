# Helpers
require_relative '../helpers/random_helper'

include RandomHelper

# Data for the account number
class Account
  def initialize(rule, min_digits, max_digits)
    @rule = rule
    @min_digits = min_digits
    @max_digits = max_digits
  end

  def account_number
    generate_number_len_range(@min_digits, @max_digits)
  end

  def account_check_digit(number)
    @rule.execute(number)
  end
end
