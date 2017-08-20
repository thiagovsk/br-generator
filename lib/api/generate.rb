require 'sinatra/base'
require 'json'

require_relative '../generators/bank_generators'
require_relative '../generators/document_generators'
require_relative '../generators/generators'

require_relative '../errors/bank_errors'

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
    create_response(200, result)
  end

  get '/generate/:option' do
    option = params['option']
    case option
    when 'bank'
      create_response(200, generate_random_bank)
    when 'cpf', 'cnpj', 'rg', 'name', 'cep'
      result = {}
      result_option = instance_variable_get("@#{option}")
      result[option] = result_option.generate
      create_response(200, result)
    else
      create_response(404, error: "Option #{option} not found!")
    end
  end

  get '/generate/:option/:config' do
    option = params['option']
    config = params['config']
    case option
    when 'bank'
      begin
        create_response(200, generate_bank(config))
      rescue BankNotFoundError
        create_response(404, error: "Bank #{config} not found!")
      end
    else
      create_response(404, error: "Option #{option} not found!")
    end
  end

  post '/generate' do
    json = JSON.parse(request.body.read)
    generation_response = if json.keys.empty?
                            create_response(400, error: 'No keys provided!')
                          else
                            result = generate_from_json(json)
                            if result.keys.empty?
                              create_response(400,
                                              error: 'No valid keys provided!')
                            else
                              create_response(200, result)
                            end
                          end
    generation_response
  end

  def generate_from_json(json)
    result = generate_document_from_json(json, {})
    generate_bank_from_json(json, result)
  end

  def generate_document_from_json(json, result)
    possible_keys = %w[cpf cnpj rg name cep]
    possible_keys.each do |k|
      if json.key?(k) && json[k].to_s.eql?('true')
        result_k = instance_variable_get("@#{k}")
        result[k] = result_k.generate
      end
    end
    result
  end

  def generate_bank_from_json(json, result)
    if json.key?('bank')
      if json['bank'].to_s.eql?('true')
        result['bank'] = generate_random_bank
      else
        generate_specific_bank(json['bank'], result)
      end
    end
    result
  end

  def generate_specific_bank(bank, result)
    result['bank'] = generate_bank(bank)
    result
  rescue BankNotFoundError
    create_response(404, error: "Bank #{json['bank']} not found!")
  end

  def create_response(code, result)
    [code, { 'Content-Type' => 'application/json' }, result.to_json]
  end
end
