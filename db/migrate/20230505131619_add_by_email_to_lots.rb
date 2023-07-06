# frozen_string_literal: true

class AddByEmailToLots < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :by_email, :string, default: 'Email não informado'
  end
end
