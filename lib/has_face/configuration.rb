module HasFace
  class Configuration

    @enable_validation = true
    @detect_url        = "http://api.face.com/faces/detect.json"

    class << self
      attr_accessor :enable_validation
      attr_accessor :detect_url
      attr_accessor :api_key
      attr_accessor :api_secret
    end

  end
end
