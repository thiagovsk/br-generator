require './lib/api/generate'
require './lib/api/validate'
require 'rack/throttle'
require 'raven'

use Rack::Throttle::Interval

Raven.configure do |config|
  config.dsn = ENV['SENTRY_URL']
end

use Raven::Rack

use GenerateAPI
run ValidateAPI
