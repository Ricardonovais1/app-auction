class Item < ApplicationRecord
  belongs_to :product_category
  validates :name, :description, :weight, :height, :depth, :width, presence: true

  validates :weight, :height, :width, :depth, numericality: { greater_than: 0 }

  before_validation :generate_code

  def generate_code 
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
