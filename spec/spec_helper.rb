require 'rspec'

require 'active_model'
require 'active_model/validations'
require 'active_record'

Dir["spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

  config.mock_with :rr

end
