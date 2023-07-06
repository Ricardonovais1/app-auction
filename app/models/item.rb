# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :product_category

  has_one :lot_item
  has_one :lot, through: :lot_item

  has_one_attached :image

  validates :name, :description, :weight, :height, :depth, :width, presence: true

  validates :weight, :height, :width, :depth, numericality: { greater_than: 0 }

  before_validation :generate_code, :set_default_values

  validate :validate_image_extension

  def validate_image_extension
    return unless image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/webp])

    errors.add(:image, 'deve ser um arquivo JPEG, PNG ou WebP')
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def set_default_values
    self.name ||= name_was
    self.description ||= description_was
    self.weight ||= weight_was
    self.height ||= height_was
    self.depth ||= depth_was
    self.width ||= width_was
  end
end
