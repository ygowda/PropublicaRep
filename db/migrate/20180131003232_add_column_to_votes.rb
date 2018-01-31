class AddColumnToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :bill_id, :string, default: ""
  end
end
