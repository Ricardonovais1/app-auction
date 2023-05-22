class Item < ApplicationRecord
  belongs_to :product_category

  has_one :lot_item
  has_one :lot, through: :lot_item

  has_one_attached :image

  validates :name, :description, :weight, :height, :depth, :width, presence: true

  validates :weight, :height, :width, :depth, numericality: { greater_than: 0 }

  before_validation :generate_code

  validate :validate_image_extension

  def validate_image_extension
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:image, 'deve ser um arquivo JPEG ou PNG')
    end
  end

  def generate_code 
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
