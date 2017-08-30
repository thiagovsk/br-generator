# Contains different helpers/tools
module RuleHelper
  def trim_number(number, weight)
    return number[0..weight.length] if number.length > weight.length
    number.rjust(weight.length, '0')
  end

  def multiply(weight_number, sum_digits, ignore_first_digit, sum = 0)
    weight_number.each.each do |w, n|
      sum += multiply_by_weight(n, w, sum_digits, ignore_first_digit)
    end
    sum
  end

  def multiply_by_weight(number, weight, sum_digits, ignore_first_digit)
    mult = number * weight
    execute_multiplication_rule(mult, sum_digits, ignore_first_digit)
  end

  def execute_multiplication_rule(mult, sum_digits, ignore_first_digit)
    mult = sum_digits(mult) if sum_digits
    return mult % 10 if ignore_first_digit
    mult
  end

  def sum_digits(number)
    digit_sum = number.to_s.chars.map(&:to_i).inject(0) { |sum, x| sum + x }
    digit_sum.inject { |n, d| n * 10 + d }
  end

  def join_numbers(number, digit, join)
    return digit unless join
    number + digit
  end
end
