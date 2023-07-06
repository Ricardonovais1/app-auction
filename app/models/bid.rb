# frozen_string_literal: true

class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validates :value, presence: { message: 'não pode ficar em branco' }

  validate :bid_value_validation, on: :create

  def bid_value_validation
    minimum_bid_value = lot.bid_value_to_beat
    return unless value.present? && value < minimum_bid_value

    errors.add(:value, ' precisa ser maior que valor mínimo')
  end
end
