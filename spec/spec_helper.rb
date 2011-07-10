require 'rspec'

require 'rails'
require 'active_model'
require 'active_model/validations'
require 'active_record'
require 'lib/has_face'

Dir["spec/support/**/*.rb"].each {|f| require f}

VALID_IMAGE_PATH   = 'spec/support/assets/hit.jpg'
INVALID_IMAGE_PATH = 'spec/support/assets/miss.jpg'

RSpec.configure do |config|

  config.mock_with :rr

  config.before :all do

    # Put your api details here for tesing.
    HasFace.api_key    = 'put your api key here for testing'    if HasFace.api_key.blank?
    HasFace.api_secret = 'put your api secret here for testing' if HasFace.api_secret.blank?

  end

end
