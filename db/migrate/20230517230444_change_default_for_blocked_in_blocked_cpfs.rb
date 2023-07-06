# frozen_string_literal: true

class ChangeDefaultForBlockedInBlockedCpfs < ActiveRecord::Migration[7.0]
  def change
    change_column_default :blocked_cpfs, :blocked, from: nil, to: true
  end
end
