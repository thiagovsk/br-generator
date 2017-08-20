require './lib/api/generate'
require './lib/api/validate'
require 'rack/throttle'

use Rack::Throttle::Interval

use GenerateAPI
run ValidateAPI
