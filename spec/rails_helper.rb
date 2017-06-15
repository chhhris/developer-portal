require 'spec_helper'

# # Prevent database truncation if the environment is production

# # Checks for pending migration and applies them before tests are run.
# # If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!
