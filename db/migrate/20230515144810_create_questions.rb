# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :lot, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
