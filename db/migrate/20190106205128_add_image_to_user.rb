class AddImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :Users, :image, :string, default: "https://image.ibb.co/jw55Ex/def_face.jpg"
  end
end
