require 'json'

# Data for the API metrics
class APIData
  def initialize(endpoint = '', request = '', response_data = '')
    @endpoint = endpoint
    @request = request
    @response_data = response_data
  end

  def to_json
    data = { endpoint: @endpoint, request: @request, response_data:
             @response_data }
    data.to_json
  end
end
