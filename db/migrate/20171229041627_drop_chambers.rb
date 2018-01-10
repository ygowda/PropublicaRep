class DropChambers < ActiveRecord::Migration
  def change
    drop_table :chambers
  end
end
