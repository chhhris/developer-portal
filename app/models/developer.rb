require 'bcrypt'

class Developer < ApplicationRecord
  include BCrypt

  has_many :applications, dependent: :destroy

  # validations around :username format

  # `Password` via bcrypt
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
