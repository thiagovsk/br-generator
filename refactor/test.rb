require_relative 'bank/bank'
require_relative 'bank/banks/banco_do_brasil'
require_relative 'bank/banks/bradesco'
require_relative 'bank/banks/itau'

bb = BancoDoBrasil.new
bradesco = Bradesco.new
itau = Itau.new

puts bb.create_numbers

puts Bank.by_code('001')

puts bradesco.create_numbers

puts Bank.by_code('237')

puts itau.create_numbers

puts Bank.by_code('341')
