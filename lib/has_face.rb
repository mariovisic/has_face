require "has_face/configuration"
require "has_face/version"
require "has_face/validator"

module HasFace

  # Add load paths straight to I18n, so engines and application can overwrite it.
  require 'i18n'
  I18n.load_path << File.expand_path('../has_face/locales/en.yml', __FILE__)

  class << self

    configs = [ :api_key, :api_secret,:enable_validation, :hostname, :detect_url]

    configs.each do |config|
      delegate config, "#{config}=", :to => HasFace::Configuration
    end

  end

end
