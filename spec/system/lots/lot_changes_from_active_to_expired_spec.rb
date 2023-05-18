require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers


describe 'Lote muda de ativo para expirado' do
  it 'quando a data de limite para lance é ultrapassada' do 
    # Arrange 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    user = User.create!(name: 'Fernanda', email: 'fernanda@exemplo.com.br', registration_number: '59310423005', password: 'password')
    travel_to Time.current - 2.week do 
      lot = Lot.create!(code: 'ABC123987', start_date: 2.day.from_now, limit_date: 1.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br') 
      bid = Bid.create!(value: 140, user_id: user.id, lot_id: lot.id, created_at: 3.day.from_now)
    end
    # Act  
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes expirados'
    end
    click_on 'ABC123987'

    # Assert
    expect(page).to have_content 'Lote expirado'
    expect(page).to have_content 'Arrematante: Fernanda | fernanda@exemplo.com.br | R$140,00'
  end
end