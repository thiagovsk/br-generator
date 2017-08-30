# Generates random numbers
module RandomHelper
  def generate_number_len(length)
    Array.new(length) { rand(1..9) }.join
  end

  def generate_number_len_range(length_min, length_max)
    generate_number_len rand(Range.new(length_min, length_max))
  end

  def get_random_line_from_file(file)
    File.readlines(file).sample.delete("\n")
  end

  def get_random_from_hash(hash)
    hash.keys.sample
  end
end
