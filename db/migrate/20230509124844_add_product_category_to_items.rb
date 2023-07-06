# frozen_string_literal: true

class AddProductCategoryToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :product_category, null: false, foreign_key: true, default: 0
  end
end
