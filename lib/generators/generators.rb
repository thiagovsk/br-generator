require 'pathname'
require_relative '../utils/randomizer'
require_relative '../utils/formatter'
include Randomizer

# Generates a name.
class Name
  def initialize
    @path = Pathname(__FILE__).dirname.parent + 'utils' + 'names'
    @names = @path + 'names.txt'
    @names_last = @path + 'names_last.txt'
  end

  def generate(include_middle = false)
    file = @names
    name = get_random_line_from_file(file) + ' '
    file = @names_last
    middle = include_middle ? get_random_line_from_file(file) + ' ' : ''
    last = get_random_line_from_file(file)
    "#{name}#{middle}#{last}"
  end
end

# Generates a CEP.
class CEP
  def generate
    number = generate_number_len(8)
    formatted = Formatter.format_number(number, 'nnnnn-nnn')
    { number: number, number_formatted: formatted }
  end
end
