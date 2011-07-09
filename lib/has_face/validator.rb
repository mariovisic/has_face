require 'active_model/validator'

module HasFace
  class Validator < ActiveModel::EachValidator

    def initialize(options)
      super
    end

   def validate_each(record, attr_name, value)
   end

  end
end

# Compatibility with ActiveModel validates method which matches option keys to their validator class
ActiveModel::Validations::HasFaceValidator = HasFace::Validator
