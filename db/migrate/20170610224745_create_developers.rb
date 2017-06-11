class CreateDevelopers < ActiveRecord::Migration[5.1]
  def change
    create_table :developers do |t|
      t.string :username
      t.string :password_hash
      t.string :email

      t.timestamps
    end
  end
end
