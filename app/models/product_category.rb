class ProductCategory < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 2 },
                   uniqueness: true
end
