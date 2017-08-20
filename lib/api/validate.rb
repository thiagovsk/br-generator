require 'sinatra/base'
require 'json'

require_relative 'br_generator'

require_relative '../banks/bank'

require_relative '../documents/document'

require_relative '../errors/bank_errors'

include BRGenerator

# This class is the endpoint for validation.
class ValidateAPI < Sinatra::Base
  error Sinatra::NotFound do
    [404, { 'Content-Type' => 'application/json' },
     { error: 'Route not found!' }.to_json]
  end

  post '/validate/bank' do
    json = JSON.parse(request.body.read)
    unless validate_bank_json json
      return create_response(400,
                             { error: 'The bank validation requires the bank
number, the agency number, the account number and the account check number!' },
                             json, '/validate/bank')
    end
    begin
      result = Bank.validate(
        json['bank'], json['agency_number'],
        (json.key?('agency_check_number') ? json['agency_check_number'] : ''),
        json['account_number'], json['account_check_number']
      )
      create_response(200, result, json, '/validate/bank')
    rescue BankNotFoundError
      create_response(404, { error: "Bank #{json['bank']} not found!" }, json,
                      '/validate/bank')
    end
  end

  post '/validate/:document' do
    document = params['document'].upcase
    json = JSON.parse(request.body.read)
    unless %w[CPF CNPJ].include?(document)
      return create_response(404,
                             { error: "Document #{document} not found!" }, json,
                             "/validate/#{document}")
    end
    unless json.key?('number')
      return create_response(400,
                             { error: 'The document validation requires the
document number!' }, json, "/validate/#{document}")
    end
    result = Document.validate(document, json['number'])
    create_response(200, result, json, "/validate/#{document}")
  end
end
