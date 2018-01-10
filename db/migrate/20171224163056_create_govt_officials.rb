class CreateGovtOfficials < ActiveRecord::Migration
  def change
    create_table :govt_officials, :id => false do |t|
      t.string :id
      t.string :firstName
      t.string :lastName
      t.date :DOB
      t.string :gender
      t.string :twitter
      t.string :chamber
      t.string :title
      t.string :state
      t.string :party
      t.integer :nextElection
      t.decimal :votesWithParty

      t.timestamps null: false
    end
  end
end
