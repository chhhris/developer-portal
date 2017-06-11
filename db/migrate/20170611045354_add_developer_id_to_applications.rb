class AddDeveloperIdToApplications < ActiveRecord::Migration[5.1]
  def change
    add_reference :applications, :developer, index: true
  end
end
