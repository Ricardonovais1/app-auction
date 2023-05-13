class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validate :bid_value_validation

  def bid_value_validation 
    minimum_bid_value = lot.bid_value_to_beat
    if value.present? && value < minimum_bid_value
      errors.add(:value, ' precisa ser maior que valor mínimo')
    end
  end
  
end
