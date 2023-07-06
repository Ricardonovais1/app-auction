# frozen_string_literal: true

class AddAboutToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :about, :string, default: ''
  end
end
