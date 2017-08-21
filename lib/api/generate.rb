require 'sinatra/base'
require 'json'

require_relative 'br_generator'

require_relative '../generators/bank_generators'
require_relative '../generators/document_generators'
require_relative '../generators/generators'

require_relative '../errors/bank_errors'

include BRGenerator
include BankGenerator

# This class is the endpoint for generation.
class GenerateAPI < Sinatra::Base
  before do
    @cpf = CPF.new
    @cnpj = CNPJ.new
    @rg = RG.new
    @name = Name.new
    @cep = CEP.new
  end

  get '/generate' do
    cpf = @cpf.generate
    cnpj = @cnpj.generate
    rg = @rg.generate
    bank = generate_random_bank
    name = @name.generate
    cep = @cep.generate
    result = {
      cpf: cpf, cnpj: cnpj, rg: rg,
      bank: bank, name: name, cep: cep
    }
    create_response(200, result, {})
  end

  get '/generate/:option' do
    option = params['option']
    case option
    when 'bank'
      create_response(200, generate_random_bank, {})
    when 'cpf', 'cnpj', 'rg', 'name', 'cep'
      result = {}
      result_option = instance_variable_get("@#{option}")
      result[option] = result_option.generate
      create_response(200, result, {})
    else
      create_response(404, { error: "Option #{option} not found!" }, {})
    end
  end

  get '/generate/:option/:config' do
    option = params['option']
    config = params['config']
    case option
    when 'bank'
      begin
        create_response(200, generate_bank(config), {})
      rescue BankNotFoundError
        create_response(404, { error: "Bank #{config} not found!" }, {})
      end
    else
      create_response(404, { error: "Option #{option} not found!" }, {})
    end
  end

  post '/generate' do
    json = JSON.parse(request.body.read)
    generation_response = if json.keys.empty?
                            create_response(400, { error: 'No keys provided!' },
                                            json)
                          else
                            result = generate_from_json(json, '/generate')
                            if result.keys.empty?
                              create_response(400,
                                              { error:
                                                  'No valid keys provided!' },
                                              json)
                            else
                              create_response(200, result, json)
                            end
                          end
    generation_response
  end
end
