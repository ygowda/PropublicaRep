class AddUrlColumnsToBills < ActiveRecord::Migration
  def change
      add_column :bills, :congressdotgov_url, :string, default: ""
      add_column :bills, :govtrack_url, :string, default: ""
  end
end
