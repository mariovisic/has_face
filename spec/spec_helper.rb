require 'rspec'
require 'vcr'

require 'rails'
require 'active_model'
require 'active_model/validations'
require 'active_record'
require 'lib/has_face'

Dir["spec/support/**/*.rb"].each {|f| require f}

VALID_IMAGE_PATH   = 'spec/support/assets/hit.jpg'
INVALID_IMAGE_PATH = 'spec/support/assets/miss.jpg'

VCR.config do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :once }
end

RSpec.configure do |config|

  config.mock_with :rr
  config.include HasFace::Test::Matchers

  config.before :all do
    # Put your api details here for tesing. This is only required if VCR is not being used
    # HasFace.api_key    = 'api_key'    if HasFace.api_key.blank?
    # HasFace.api_secret = 'api_secret' if HasFace.api_secret.blank?
  end

end
