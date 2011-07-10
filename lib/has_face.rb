require 'has_face/configuration'
require 'has_face/validator'
require 'has_face/version'
require 'has_face/test/matchers'

module HasFace

  # Error classes
  class FaceAPIError < StandardError; end
  class HTTPRequestError < StandardError; end

  # Add load paths straight to I18n, so engines and application can overwrite it.
  require 'i18n'
  I18n.load_path << File.expand_path('../has_face/locales/en.yml', __FILE__)

  class << self

    configs = [ :api_key, :api_secret, :enable_validation, :detect_url, :skip_validation_on_error ]

    configs.each do |config|
      delegate config, "#{config}=", :to => HasFace::Configuration
    end

    def configure
      yield self
    end

  end

end
