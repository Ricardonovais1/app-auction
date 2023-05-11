class Item < ApplicationRecord
  belongs_to :product_category

  has_one_attached :image

  validates :name, :description, :weight, :height, :depth, :width, presence: true

  validates :weight, :height, :width, :depth, numericality: { greater_than: 0 }

  before_validation :generate_code

  has_one :lot_item
  has_one :lot, through: :lot_item

  def generate_code 
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
