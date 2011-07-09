require 'active_model/validator'

module HasFace
  class Validator < ActiveModel::EachValidator

    def validate_each(record, attr_name, value)

      if record.send(attr_name).present? && HasFace.enable_validation

        params     = { :api_key => HasFace.api_key, :api_secret => HasFace.api_secret, :urls => [HasFace.hostname avatar.url].join }
        uri_string = "#{HasFace.detect_url}?#{params.to_param}"
        uri_string = URI.escape(CGI.escape(uri_string),'.')

        url          = URI.parse(uri_string)
        request      = Net::HTTP::Get.new(uri_string)
        response     = Net::HTTP.start(url.host, url.port) {|http| http.request(request) }

        face_results = JSON.parse(response.body)
        tags         = face_results.try(:[], 'photos').try(:first).try(:[], 'tags') || []

        # Add errors if no tags are present
        unless tags.present?
          errors.add(attr_name, :no_face)
        end

      end

    end

  end
end

# Compatibility with ActiveModel validates method which matches option keys to their validator class
ActiveModel::Validations::HasFaceValidator = HasFace::Validator
