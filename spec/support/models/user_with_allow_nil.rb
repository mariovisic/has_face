require './spec/support/models/base_user'

class UserWithAllowNil < BaseUser
  validates :avatar, :has_face => true, :allow_nil => true
end
