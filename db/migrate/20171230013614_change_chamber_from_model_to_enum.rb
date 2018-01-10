class ChangeChamberFromModelToEnum < ActiveRecord::Migration
  def change
    change_column :govt_officials, :chamber, :integer
  end
end
