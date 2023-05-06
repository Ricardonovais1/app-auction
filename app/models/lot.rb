class Lot < ApplicationRecord
  validates :code, :start_date, :limit_date, :minimum_bid_value, :minimum_bid_difference, presence: true
end
