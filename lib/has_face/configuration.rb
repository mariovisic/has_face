module HasFace
  class Configuration

    @enable_validation        = true
    @skip_validation_on_error = false
    @transfer_method          = :upload
    @detect_url               = "http://api.face.com/faces/detect.json"

    class << self
      attr_accessor :enable_validation
      attr_accessor :detect_url
      attr_accessor :api_key
      attr_accessor :api_secret
      attr_accessor :skip_validation_on_error
      attr_accessor :transfer_method
    end

  end
end
