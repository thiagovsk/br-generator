require_relative 'bank/bank'
require_relative 'bank/banks/banco_do_brasil'
require_relative 'bank/banks/bradesco'

bb = BancoDoBrasil.new

puts bb.create_numbers

puts Bank.by_code('001')

bradesco = Bradesco.new

puts bradesco.create_numbers

puts Bank.by_code('237')