require 'rails_helper'

describe 'Usuário vê link de fazer lances na página do lote' do
  it 'com sucesso' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.ago, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 

    # Act 
    login_as(user)
    visit root_path
    click_on 'ABC121117'

    # Assert
    expect(page).to have_button 'Fazer um lance'
  end
end