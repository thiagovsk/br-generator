require_relative '../utils/api_data.rb'

# Utilities for the API endpoints
module BRGenerator
  def create_response(code, result, request)
    result = result.to_json
    metrics_data = build_metrics_data(code, request)
    send_metrics(result, metrics_data)
    [code, { 'Content-Type' => 'application/json' }, result]
  end

  def send_metrics(result, metrics_data)
    Raven.capture_message(result, level: 'info', extra: metrics_data)
  end

  def build_metrics_data(code, request)
    { response: code, request: request }
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
        generate_specific_bank(json, result)
      end
    end
    result
  end

  def generate_specific_bank(json, result)
    bank = json['bank']
    result['bank'] = generate_bank(bank)
    result
  rescue BankNotFoundError
    create_response(404, { error: "Bank #{json['bank']} not found!" }, json)
  end

  def validate_bank_json(json)
    json.key?('bank') && json.key?('agency_number') &&
      json.key?('account_number') && json.key?('account_check_number')
  end
end
