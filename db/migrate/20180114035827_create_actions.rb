class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :action_id
      t.integer :chamber
      t.string :action_type
      t.date :date
      t.string :description
      t.integer :bill_id

      t.timestamps null: false
    end
  end
end
