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

      image       = record.send(attr_name)
      @image_path = image.respond_to?(:path) ? image.path : nil

      # Skip validation if our image is nil/blank and allow nil/blank is on
      return if (@allow_nil && image.nil?) || (@allow_blank && image.blank?)

      # Add an error if the image path is blank
      return record.errors.add(attr_name, :no_face) if @image_path.blank?

      # Get the response and parse to JSON
      raw_response = RestClient.post(HasFace.detect_url, params)
      response     = JSON.parse(raw_response)

      # Error handling for failed responses
      return handle_api_error(response) unless response['status'] == 'success'

      # Add errors if no tags are present
      tags = response.try(:[], 'photos').try(:first).try(:[], 'tags')
      record.errors.add(attr_name, :no_face) if tags.blank?

    rescue RestClient::Exception => error
      return handle_request_error(error)
    end

    protected

    def params
      { :api_key => HasFace.api_key, :api_secret => HasFace.api_secret, :image => File.new(@image_path, 'r') }
    end

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
