class AddVisionToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :Posts, :vision, :boolean, default: true
  end
end
