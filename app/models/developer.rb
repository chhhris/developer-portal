require 'bcrypt'

class Developer < ApplicationRecord
  include BCrypt

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  USERNAME_REGEX = /\A[a-zA-Z0-9._-]+\z/i

  has_many :applications, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true
  validates :password_hash, presence: true

  validates_format_of :username, with: USERNAME_REGEX
  validates_format_of :email, with: EMAIL_REGEX

  # Password hashing via bcrypt
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
