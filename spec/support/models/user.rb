class User < BaseUser

  validates :avatar, :has_face => true

end

class UserWithFaceValidation < User; end
class UserWithoutAllowBlank < User; end
class UserWithoutAllowNil < User; end
