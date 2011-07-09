require "has_face/configuration"
require "has_face/version"
require "has_face/validator"

module HasFace

  class << self

    configs = [ :api_key, :api_secret,:enable_validation, :hostname, :detect_url]

    configs.each do |config|
      delegate config, "#{config}=", :to => HasFace::Configuration
    end

  end

end
