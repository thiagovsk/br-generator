require_relative 'data_class'
class TestClass < DataClass
  def initialize
    super({ test: 'a' })
  end
end

test = TestClass.new
puts test.test
test.test = 'b'
puts test.test
