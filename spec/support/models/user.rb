class User < ActiveRecord::Base

  has_one :avatar

end

class UserWithoutFaceValidation < User; end
