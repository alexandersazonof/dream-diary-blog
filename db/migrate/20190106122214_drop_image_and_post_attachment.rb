class DropImageAndPostAttachment < ActiveRecord::Migration[5.2]
  def change
    drop_table :post_attachments
    drop_table :images
  end
end
