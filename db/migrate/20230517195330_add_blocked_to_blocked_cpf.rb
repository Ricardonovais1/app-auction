class AddBlockedToBlockedCpf < ActiveRecord::Migration[7.0]
  def change
    add_column :blocked_cpfs, :blocked, :boolean
  end
end
