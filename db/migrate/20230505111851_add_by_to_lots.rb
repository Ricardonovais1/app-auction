# frozen_string_literal: true

class AddByToLots < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :by, :string, default: 'Não informado'
  end
end
