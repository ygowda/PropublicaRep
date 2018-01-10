class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :govt_officials, :id, :member_id
  end
end
