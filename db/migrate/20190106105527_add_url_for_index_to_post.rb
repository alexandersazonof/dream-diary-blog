class AddUrlForIndexToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :Posts, :url_mini, :string
  end
end
