# frozen_string_literal: true

class ChangeDefaultInBlockedInBlockedCpfs < ActiveRecord::Migration[7.0]
  def change
    change_column_default :blocked_cpfs, :blocked, from: true, to: false
  end
end
