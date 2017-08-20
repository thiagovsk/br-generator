require_relative '../utils/rule'
require_relative '../utils/formatter'

require_relative 'document_util'

# Data for the document numbers
class Document
  attr_accessor :digits, :format_str, :rules, :ending, :document_generator
  def generate
    @document_util.generate
  end

  def self.validate(type, number)
    DocumentUtil.validate(type, number)
  end

  def generate_with_data(number)
    @document_util.generate_with_data number
  end
end
