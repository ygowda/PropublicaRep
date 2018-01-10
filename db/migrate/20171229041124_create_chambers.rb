class CreateChambers < ActiveRecord::Migration
  def change
    create_table :chambers do |t|

      t.timestamps null: false
    end
  end
end
