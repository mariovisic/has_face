require 'rspec'

require 'active_model'
require 'active_model/validations'
require 'remarkable/active_record'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |c|

  config.use_transactional_fixtures = true
  c.mock_with :rr

end
