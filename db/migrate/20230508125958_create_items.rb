class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :weight
      t.integer :height
      t.integer :depth
      t.integer :width
      t.string :code

      t.timestamps
    end
  end
end