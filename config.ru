require './lib/api/generate'
require './lib/api/validate'
require 'rack/throttle'
require 'rollbar'

use Rack::Throttle::Interval

Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_TOKEN']
end

use GenerateAPI
run ValidateAPI
