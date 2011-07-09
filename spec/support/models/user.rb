class User < ActiveRecord::Base

  has_one :avatar

  # validates :avatar, :has_face => true

end
