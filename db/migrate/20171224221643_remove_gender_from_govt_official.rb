class RemoveGenderFromGovtOfficial < ActiveRecord::Migration
  def change
    remove_column :govt_officials, :gender, :string
  end
end
