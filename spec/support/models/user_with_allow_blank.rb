class UserWithAllowBlank < BaseUser
  validates :avatar, :has_face => true, :allow_blank => true
end
