class AddImageToTable < ActiveRecord::Migration
  def change
    add_column :govt_officials, :image_string, :string
  end
end
