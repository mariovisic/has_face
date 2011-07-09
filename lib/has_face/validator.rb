require 'net/http'

module HasFace
  class Validator < ActiveModel::EachValidator

    def initialize(options)
      @allow_nil, @allow_blank = options.delete(:allow_nil), options.delete(:allow_blank)
      super
    end

    def validate_each(record, attr_name, value)

      # Skip validation if globally turned off
      return if HasFace.enable_validation == false

      image     = record.send(attr_name)
      image_url = image.try(:url)

      # Skip validation if our image is nil/blank and allow nil/blank is on
      return if (@allow_nil && image.nil?) || (@allow_blank && image.blank?)

      # Add an error if the url is blank
      record.errors.add(attr_name, :no_face) if image_url.blank?

      # Params and URL Setup
      params       = { :api_key => HasFace.api_key, :api_secret => HasFace.api_secret, :urls => [HasFace.hostname, image_url].join }
      uri_string   = get_uri_string(params)
      url          = URI.parse(uri_string)

      # Get our request and response objects
      request      = Net::HTTP::Get.new(uri_string)
      response     = get_response(url.host, url.port, request)

      # Turn the response into tags
      face_results = JSON.parse(response.body)
      tags         = face_results.try(:[], 'photos').try(:first).try(:[], 'tags') || []

      # Add errors if no tags are present
      unless tags.present?
        record.errors.add(attr_name, :no_face)
      end

    end

    private

    def get_uri_string(params)
      params_string = params.map { |k,v| "#{k}=#{v}" }.join('&')
      uri_string    = "#{HasFace.detect_url}?#{params_string}"

      URI.escape(uri_string)
    end

    def get_response(host, port, request)
      Net::HTTP.start(host, port) {|http| http.request(request) }
    end

  end
end

# Compatibility with ActiveModel validates method which matches option keys to their validator class
ActiveModel::Validations::HasFaceValidator = HasFace::Validator
