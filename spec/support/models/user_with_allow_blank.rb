require './spec/support/models/base_user'

class UserWithAllowBlank < BaseUser
  validates :avatar, :has_face => true, :allow_blank => true
end
