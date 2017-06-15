# == Schema Information
#
# Table name: developers
#
#  id             :integer
#  username       :string
#  email          :string
#  password_hash  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null

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

  before_create :generate_authentication_token

  # Password hashing via bcrypt
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  private

  def generate_authentication_token
    loop do
      self.authentication_token = ApiAuth.generate_secret_key
      break unless Developer.find_by(authentication_token: authentication_token)
    end
  end
end
