class AddDefaultValuesToVotes < ActiveRecord::Migration
  def change
    change_column :votes, :democratic, :integer, array:true, default: [0,0]
    change_column :votes, :republican, :integer, array:true, default: [0,0]
    change_column :votes, :independent, :integer, array:true, default: [0,0]
  end
end
