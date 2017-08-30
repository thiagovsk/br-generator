require_relative 'helpers/rule_helper'

include RuleHelper

# Executes the check digit rule
class Rule
  def initialize(params)
    @bank = params[:bank]
    @modulo = params[:modulo]
    @weight = params[:weight]
    @after_modulo_rule = params[:after_modulo_rule]
    @before_modulo_rule = params.fetch(:before_modulo_rule, nil)
    @sum_digits = params.fetch(:sum_digits, false)
    @ignore_first_digit = params.fetch(:ignore_first_digit, false)
  end

  def execute(number, join = false)
    number = trim_number(number, @weight)
    digit = execute_rules(number)
    join_numbers(number, digit, join)
  end

  def execute_rules(number)
    @weight_number = @weight.zip(number.split('').map(&:to_i))
    number = before_modulo_rule
    after_modulo_rule(number)
  end

  def before_modulo_rule
    sum = multiply(@weight_number, @sum_digits, @ignore_first_digit)
    return sum if @before_modulo_rule.nil?
    @bank.send(@before_modulo_rule, sum)
  end

  def after_modulo_rule(number)
    mod = number % @modulo
    @bank.send(@after_modulo_rule, mod)
  end
end
