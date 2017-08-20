# Generates a lot of things.
module Randomizer
  def generate_number_len(length = 3)
    Array.new(length) { rand(1..9) }.join
  end

  def generate_number_len_range(length_min = 1, length_max = 3)
    generate_number_len rand(Range.new(length_min, length_max))
  end

  def generate_number_range(range = 0..1000)
    rand(range)
  end

  def generate_random_string(length = 30, lowercase = true, numbers = true,
                             uppercase = true, symbols = true)
    arr = []

    arr.push(*'a'..'z') if lowercase
    arr.push(*1..9) if numbers
    arr.push(*'A'..'Z') if uppercase
    arr.push(*'!'..'?') if symbols
    Array.new(length) do
      arr.sample
    end.join
  end

  def get_random_line_from_file(file)
    File.readlines(file).sample.delete("\n")
  end

  def get_random_from_hash(hash)
    hash.keys.sample
  end
end
