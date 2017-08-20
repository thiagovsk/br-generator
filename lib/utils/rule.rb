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
    number = if number.length > @weight.length
               number[0..@weight.length]
             else
               number.rjust(@weight.length, '0')
             end

    sum = exec_before_modulo(number)
    mod = exec_after_modulo(sum)

    return "#{number}#{mod}" if join
    mod.to_s
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
      mult = w.to_i * number[i].to_i
      mult = @sum_digits ? sum_digits(mult) : mult
      mult = @ignore_first_digit ? mult % 10 : mult
      sum += mult
      i += 1
    end
    sum
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
