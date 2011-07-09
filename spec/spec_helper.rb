require 'rspec'

require 'active_model'
require 'active_model/validations'
require 'active_record'
require 'lib/has_face'

Dir["spec/support/**/*.rb"].each {|f| require f}

INVALID_IMAGE_URL = "/u/17429266/swoonme/test/miss.jpeg"

RSpec.configure do |config|

  config.mock_with :rr

end
