# frozen_string_literal: true

class AddRegistrationNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :registration_number, :string
  end
end
