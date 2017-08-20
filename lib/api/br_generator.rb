require 'rollbar'
require_relative '../utils/api_data.rb'

# Utilities for the API endpoints
module BRGenerator
  def create_response(code, result, request, endpoint)
    api_data = APIData.new(endpoint, request, result, code)
    send_data(api_data.to_json)
    [code, { 'Content-Type' => 'application/json' }, result.to_json]
  end

  def send_data(data)
    Rollbar.info(data)
  end

  def generate_from_json(json, endpoint)
    result = generate_document_from_json(json, {})
    generate_bank_from_json(json, result, endpoint)
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

  def generate_bank_from_json(json, result, endpoint)
    if json.key?('bank')
      if json['bank'].to_s.eql?('true')
        result['bank'] = generate_random_bank
      else
        generate_specific_bank(json, result, endpoint)
      end
    end
    result
  end

  def generate_specific_bank(json, result, endpoint)
    bank = json['bank']
    result['bank'] = generate_bank(bank)
    result
  rescue BankNotFoundError
    create_response(404, { error: "Bank #{json['bank']} not found!" }, json,
                    endpoint)
  end

  def validate_bank_json(json)
    json.key?('bank') && json.key?('agency_number') &&
      json.key?('account_number') && json.key?('account_check_number')
  end
end
