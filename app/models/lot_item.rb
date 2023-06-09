class LotItem < ApplicationRecord
  belongs_to :item
  belongs_to :lot

  validates :item_id, uniqueness: true, presence: true, numericality: { greater_than: 0 }
end
