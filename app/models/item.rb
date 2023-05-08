class Item < ApplicationRecord
  validates :name, :description, :weight, :height, :depth, :width, presence: true

  before_validation :generate_code

  def generate_code 
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
