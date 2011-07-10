require 'rest_client'

module HasFace
  class Validator < ActiveModel::EachValidator

    def initialize(options)
      @allow_nil, @allow_blank = options.delete(:allow_nil), options.delete(:allow_blank)
      super
    end

    def validate_each(record, attr_name, value)

      # Skip validation if globally turned off
      return if HasFace.enable_validation == false

      image      = record.send(attr_name)
      image_path = image.try(:path) if image.respond_to?(:path)

      # Skip validation if our image is nil/blank and allow nil/blank is on
      return if (@allow_nil && image.nil?) || (@allow_blank && image.blank?)

      # Add an error if the url is blank
      return record.errors.add(attr_name, :no_face) if image_path.blank?

      # Get an parse the JSON response
      params   = { :api_key => HasFace.api_key, :api_secret => HasFace.api_secret, :image => File.new(image_path, 'rb') }

      begin
        response = RestClient.post(HasFace.detect_url, params)
      rescue RestClient::Exception => error
        return handle_request_error(error)
      end

      json_response = JSON.parse(response.body)

      # Error handling for failed responses
      return handle_api_error(json_response) unless json_response['status'] == 'success'

      tags = json_response.try(:[], 'photos').try(:first).try(:[], 'tags') || []

      # Add errors if no tags are present
      unless tags.present?
        record.errors.add(attr_name, :no_face)
      end

    end

    protected

    def handle_api_error(response)
      error_message = "face.com API Error: \"#{response['error_message']}\" Code: #{response['error_code']}"

      if HasFace.skip_validation_on_error
        Rails.logger.warn error_message if Rails.logger.present?
        true
      else
        raise FaceAPIError.new error_message
      end
    end

    def handle_request_error(error)
      error_message = "has_face HTTP Request Error: \"#{error.message}\""

      if HasFace.skip_validation_on_error
        Rails.logger.warn error_message if Rails.logger.present?
        true
      else
        raise HTTPRequestError.new error_message
      end
    end

  end
end

# Compatibility with ActiveModel validates method which matches option keys to their validator class
ActiveModel::Validations::HasFaceValidator = HasFace::Validator
