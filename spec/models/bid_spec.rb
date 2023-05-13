require 'rails_helper'

RSpec.describe Bid, type: :model do
  # describe '#valid?' do 
  #   it 'falso quando lance é menor que o determinado na função bid value to beat' do
  #     # Arrange 
  #     user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
  #     lot = Lot.create!(code: 'ABC121117', start_date: 1.day.ago, limit_date: 1.week.from_now, 
  #                       minimum_bid_value: 100, minimum_bid_difference: 10, 
  #                       by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 

  #     # Act 
  #     login_as(user)
  #     visit root_path
  #     click_on 'Lote ABC121117'
  #     click_on 'Fazer um lance'
  #     fill_in 'Valor', with: 200
  #     click_on 'Confirmar lance'

  #     # Assert
  #     expect(page).to have_content 'Lance realizado com sucesso.'
  #     expect(page).to have_content "Lance mínimo: R$210,00"
  #   end
  # end
end
