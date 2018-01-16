class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.date :date
      t.integer :roll_call
      t.string :question
      t.string :result
      t.integer :total_yes
      t.integer :total_no
      t.integer :total_not_voting

      t.timestamps null: false
    end
  end
end
