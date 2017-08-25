# Generates validation digits based on modulo 11/10.
class Rule
  def initialize(obj, weight, after_modulo_rule = [], before_modulo_rule = nil)
    @obj = obj
    @weight = weight
    @after_modulo_rule = after_modulo_rule
    @before_modulo_rule = before_modulo_rule
    @modulo = 11
    @sum_digits = false
    @ignore_first_digit = false
  end

  def with_modulo(modulo)
    @modulo = modulo
    self
  end

  def should_sum_digits
    @sum_digits = true
    self
  end

  def should_ignore_first_digit
    @ignore_first_digit = true
    self
  end

  def execute(number, join = false)
    number = format_number(number)
    mod = exec_rules(number)
    return join_numbers(number, mod) if join
    mod
  end

  def format_number(number)
    return number[0..@weight.length] if number.length > @weight.length
    number.rjust(@weight.length, '0')
  end

  def exec_rules(number)
    sum = exec_before_modulo(number)
    exec_after_modulo(sum)
  end

  def join_numbers(number, mod)
    "#{number}#{mod}"
  end

  def exec_before_modulo(number)
    sum = multiply(number)
    return sum if @before_modulo_rule.nil?
    @obj.send(@before_modulo_rule, sum)
  end

  def multiply(number)
    sum = 0
    i = 0
    @weight.each do |w|
      sum += multiply_weight(w.to_i, number[i].to_i)
      i += 1
    end
    sum
  end

  def multiply_weight(w, number)
    mult = w * number
    mult = sum_digits(mult) if @sum_digits
    return mult % 10 if @ignore_first_digit
    mult
  end

  def exec_after_modulo(sum)
    mod = sum % @modulo
    @obj.send(@after_modulo_rule, mod)
  end

  def sum_digits(number)
    sum = 0

    while number > 0
      sum += number % 10
      number /= 10
    end

    sum
  end
end
