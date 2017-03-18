class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true

  def password=(pw)
    self.password_digest = BCrypt::Password.create(pw)
    @password = pw
  end
end
