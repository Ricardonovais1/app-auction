# frozen_string_literal: true

class AddVisibilityToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :visibility, :integer, default: 0
  end
end
