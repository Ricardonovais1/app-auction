class LotItem < ApplicationRecord
  belongs_to :item
  belongs_to :lot

  # validates :item_id, presence: { message: 'Você deve selecionar um item' }, numericality: { greater_than: 0, message: 'Você deve selecionar um item' }


  validates :item_id, uniqueness: true, presence: true
end
