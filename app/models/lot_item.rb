class LotItem < ApplicationRecord
  belongs_to :item
  belongs_to :lot

  validates :item_id, uniqueness: { scope: :lot_id }
end
