require 'bcrypt'

class Developer < ApplicationRecord
  include BCrypt

  has_many :applications, dependent: :destroy
end
