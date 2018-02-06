class AddColumnsToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :democratic, :integer, array:true, default: []
    add_column :votes, :republican, :integer, array:true, default: []
    add_column :votes, :independent, :integer, array:true, default: []
  end
end
