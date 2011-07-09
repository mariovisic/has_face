class BaseUser < ActiveRecord::Base

  has_one :avatar

end

class UserWithoutFaceValidation < BaseUser; end
