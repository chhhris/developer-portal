class AddAuthenticationTokenToDevelopers < ActiveRecord::Migration[5.1]
  def change
    add_column :developers, :authentication_token, :string
  end
end
