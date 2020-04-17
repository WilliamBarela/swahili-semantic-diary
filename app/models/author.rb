class Author < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email,
    presence: true

  validates :email,
    uniqueness: true

  validate :valid_password?

  def valid_password?
    errors.add(:password, "Password must be between 8 and 32 characters.") unless self.password.length.between?(8,32)
  end
end
