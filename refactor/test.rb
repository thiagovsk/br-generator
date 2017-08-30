require_relative 'bank/bank'
require_relative 'bank/banks/banco_do_brasil'

bb = BancoDoBrasil.new

puts bb.create_numbers

puts Bank.by_code('001')