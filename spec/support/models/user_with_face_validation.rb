class UserWithFaceValidation < User

  validates :avatar, :has_face => true

end
