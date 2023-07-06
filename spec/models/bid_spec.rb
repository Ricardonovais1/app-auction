# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe '#valid?' do
    it 'falso quando lance é menor que o determinado na função bid_value_to_beat' do
      # Arrange
      user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607',
                          password: 'password')
      User.create!(name: 'Ana', email: 'ana@exemplo.com.br', registration_number: '79533934093',
                   password: 'password')
      lot = Lot.create!(code: 'ABC121117', start_date: 2.day.from_now, limit_date: 1.week.from_now,
                        minimum_bid_value: 100, minimum_bid_difference: 10,
                        by: 'Ana', by_email: 'ana@leilaodogalpao.com.br', status: :approved)

      # Act
      travel_to 3.day.from_now do
        login_as(user)
        bid = Bid.new(value: 20, user:, lot:)
        result = bid.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end
end
