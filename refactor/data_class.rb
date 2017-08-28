# Implementation of Kotlin's data classes
class DataClass
  def initialize(vars)
    vars.each do |k, v|
      create_variable(k)
      create_get_method(k)
      create_set_method(k)
      self.send("#{k}=".to_sym, v) unless v.nil?
    end
  end

  def create_variable(var)
    instance_variable_set("@#{var}", nil)
  end

  def create_get_method(var)
    self.class.send(:define_method, var.to_sym) do
      instance_variable_get("@#{var}")
    end
  end

  def create_set_method(var)
    self.class.send(:define_method, "#{var}=".to_sym) do |value|
      instance_variable_set("@#{var}", value)
    end
  end
end