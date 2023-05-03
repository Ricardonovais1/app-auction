class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.string :code
      t.date :start_date
      t.date :limit_date
      t.integer :minimum_bid_value
      t.integer :minimum_bid_difference

      t.timestamps
    end
  end
end
