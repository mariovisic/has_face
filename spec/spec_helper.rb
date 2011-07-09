require 'rspec'

require 'active_model'
require 'active_model/validations'
require 'active_record'
require 'lib/has_face'

Dir["spec/support/**/*.rb"].each {|f| require f}

INVALID_IMAGE_URL = "/u/17429266/swoonme/test/miss.jpeg"
VALID_IMAGE_URL   = "/u/17429266/swoonme/test/hit.jpeg"

RSpec.configure do |config|

  config.mock_with :rr

  config.before :all do
    # Test Files are kept on dropbox
    HasFace.hostname = "http://dl.dropbox.com"
  end

end
