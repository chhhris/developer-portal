class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :key
      t.string :description

      t.timestamps
    end
  end
end
