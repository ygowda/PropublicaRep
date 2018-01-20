class AddColumnsToGovtOfficial < ActiveRecord::Migration
  def change
    add_column :govt_officials, :bills_sponsored, :integer
    add_column :govt_officials, :bills_cosponsored, :integer
    add_column :govt_officials, :missed_votes, :decimal
  end
end
