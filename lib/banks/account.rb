# Data for the account numbers.
class Account
  attr_accessor :min_digits, :max_digits, :default_begin
  def initialize(min_digits, max_digits, default_begin = '')
    @min_digits = min_digits
    @max_digits = max_digits
    @default_begin = default_begin
  end
end
