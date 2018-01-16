class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :bill_id
      t.string :bill_slug
      t.string :bill_number
      t.string :title
      t.string :short_title
      t.string :sponsor_id
      t.string :sponsor_party
      t.string :sponsor_state
      t.date :introduced_date
      t.text :summary
      t.text :short_summary

      t.timestamps null: false
    end
  end
end
