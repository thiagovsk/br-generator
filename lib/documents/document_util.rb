require_relative '../utils/randomizer'
require_relative '../generators/document_generators'
include Randomizer

# Generates the document with valid digits.
class DocumentUtil
  def initialize(document)
    @digits = document.digits
    @format_str = document.format_str
    @rules = document.rules
    @ending = document.ending
  end

  def generate
    result = {}

    number = generate_number_len(@digits) + @ending
    number = generate_check_numbers number unless @rules.nil?
    result[:number] = number
    result[:number_formatted] = Formatter.format_number(number, @format_str)

    result
  end

  def generate_with_data(number)
    digits = @digits + @ending.length
    number_max_len = number[0..digits - 1]

    number = generate_check_numbers number_max_len
    { number: number, number_formatted: Formatter
      .format_number(number, @format_str) }
  end

  def generate_check_numbers(number)
    @rules.each do |r|
      number = r.execute(number, true)
    end
    number
  end

  def self.validate(type, number)
    number = number.gsub(/\D/, '')
    document = Object.const_get(type).new

    result = document.generate_with_data(number)
    result[:valid] = (number == result[:number])

    result
  end
end
