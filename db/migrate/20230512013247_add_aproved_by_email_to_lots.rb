# frozen_string_literal: true

class AddAprovedByEmailToLots < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :approved_by_email, :string, default: 'none'
  end
end
