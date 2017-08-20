require_relative '../utils/rule'
require_relative '../utils/formatter'
require_relative '../documents/document'
require_relative '../documents/document_util'

# Responsible to create a CPF document.
class CPF < Document
  def initialize
    initialize_weights
    @digits = 9
    @format_str = 'nnn.nnn.nnn-nn'
    first_rule = Rule.new(self, @first_digit_weights, 'after_rule',
                          'before_rule')
    second_rule = Rule
                  .new(self, @second_digit_weights, 'after_rule', 'before_rule')
    @rules = [first_rule, second_rule]
    @ending = ''
    @document_util = DocumentUtil.new(self)
  end

  def initialize_weights
    @first_digit_weights = [10, 9, 8, 7, 6, 5, 4, 3, 2]
    @second_digit_weights = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2]
  end

  def before_rule(sum)
    sum * 10
  end

  def after_rule(mod)
    mod == 10 ? '0' : mod.to_s
  end
end

# Responsible to create a CNPJ document.
class CNPJ < Document
  def initialize
    @first_digit_weights = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    @second_digit_weights = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    @digits = 8
    @format_str = 'nn.nnn.nnn/nnnn-nn'
    first_rule = Rule.new(self, @first_digit_weights, 'after_rule')
    second_rule = Rule.new(self, @second_digit_weights, 'after_rule')
    @rules = [first_rule, second_rule]
    @ending = '0001'
    @document_util = DocumentUtil.new(self)
  end

  def after_rule(mod)
    mod < 2 ? '0' : (11 - mod).to_s
  end
end

# Responsible to create a RG document.
class RG < Document
  def initialize
    @digit_weights = [2, 3, 4, 5, 6, 7, 8, 9]
    @digits = 8
    @format_str = 'nn.nnn.nnn-n'
    first_rule = Rule.new(self, @digit_weights, 'after_rule')
    @rules = [first_rule]
    @ending = ''
    @document_util = DocumentUtil.new(self)
  end

  def after_rule(mod)
    mod = 11 - mod
    if mod == 10
      'X'
    elsif mod == 11
      '0'
    else
      mod.to_s
    end
  end
end
