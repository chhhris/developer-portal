class Application < ApplicationRecord
  belongs_to :developer

  KEY_REGEX = /\A[a-zA-Z0-9.-]+\z/i

  validates :name, presence: true
  validates :key, presence: true
  validates :description, presence: true

  validates_format_of :key, with: KEY_REGEX
end
