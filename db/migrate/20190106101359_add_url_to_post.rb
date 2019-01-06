class AddUrlToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :Posts, :url, :string
  end
end
