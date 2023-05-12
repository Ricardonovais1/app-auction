class AddAprovedByToLots < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :approved_by, :string, default: 'none'
  end
end
