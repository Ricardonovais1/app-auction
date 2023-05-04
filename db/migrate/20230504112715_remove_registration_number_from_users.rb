class RemoveRegistrationNumberFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :registration_number, :integer
  end
end
