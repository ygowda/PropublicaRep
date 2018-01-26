class AddColumnsToBills < ActiveRecord::Migration
  def change
    add_column :bills, :latest_major_action, :string, default: ""
    add_column :bills, :latest_major_action_date, :date
  end
end
