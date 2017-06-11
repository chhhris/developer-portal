class Application < ApplicationRecord
  belongs_to :developer

  # validations around :key format
end
