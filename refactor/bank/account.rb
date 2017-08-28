require_relative '../data_class'

# Holds the information for the account numbers
class Account < DataClass
  def initialize(min_digits, max_digits)
    super({ min_digits: min_digits, max_digits: max_digits })
  end
end