# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validates :lot_id, uniqueness: true
end
