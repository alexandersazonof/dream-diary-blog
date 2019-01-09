class AddDefaultIconToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :string, default: "user.png"
  end
end
