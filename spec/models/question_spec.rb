require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '#valid?' do 
    it 'falso quando corpo da mensagem está vazio' do
      user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
      lot = Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30', 
                        minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved) 
      question = Question.new(body: '', user_id: user.id, lot_id: lot.id)

      result = question.valid?

      expect(result).to eq false
    end

    it 'falso quando corpo da mensagem tem menos de 10 caracteres' do
      user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
      lot = Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30', 
                        minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved) 
      question = Question.new(body: 'Olá', user_id: user.id, lot_id: lot.id)

      result = question.valid?

      expect(result).to eq false
    end
  end
end
