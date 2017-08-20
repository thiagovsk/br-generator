# Formats numbers.
module Formatter
  def self.format_number(number, format_str)
    result = ''

    i = 0
    format_str.split('').each do |f|
      result += f == 'n' ? number[i] : f
      i += 1 if f == 'n'
    end

    result
  end
end
