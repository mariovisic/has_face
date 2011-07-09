require "has_face/configuration"
require "has_face/version"
require "has_face/validator"

module HasFace

  class << self
    delegate :enable_validation, :enable_validation=, :hostname, :hostname=, :to => HasFace::Configuration
  end

end
