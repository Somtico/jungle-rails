class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, :password, :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }

  # Add this callback to strip spaces from email before saving
  before_validation :strip_whitespace

  def self.authenticate_with_credentials(email, password)
    # Strip leading/trailing spaces and downcase the email
    email = email.strip.downcase
    # Find user by the downcased email
    user = User.where("LOWER(email) = ?", email).first
    # Authenticate the user with the given password
    user && user.authenticate(password) ? user : nil
  end

  private

  def strip_whitespace
    self.email = self.email.strip if self.email.present?
  end
end