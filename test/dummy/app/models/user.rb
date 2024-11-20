class User < ApplicationRecord
  has_secure_password
  has_secure_token :access_token, length: 32

  # Validations
  validates :email_address, presence: true, uniqueness: true
end
