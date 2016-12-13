class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true

  def password=(pw)
    self.password_digest = BCrypt::Password.create(pw)
    @password = pw
  end
end
