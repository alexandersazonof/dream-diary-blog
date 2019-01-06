class EditImageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :Users, :icon, :text
  end
end
