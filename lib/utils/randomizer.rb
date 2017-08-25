# Generates a lot of things.
module Randomizer
  def generate_number_len(length = 3)
    Array.new(length) { rand(1..9) }.join
  end

  def generate_number_len_range(length_min = 1, length_max = 3)
    generate_number_len rand(Range.new(length_min, length_max))
  end

  def get_random_line_from_file(file)
    File.readlines(file).sample.delete("\n")
  end

  def get_random_from_hash(hash)
    hash.keys.sample
  end
end
