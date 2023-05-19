require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers


describe 'Usuário vê link de fazer lances na página do lote' do
  it 'com sucesso' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    travel_to 2.days.ago do
      lot = Lot.create!(code: 'ABC121117', start_date: 3.days.from_now, limit_date: 1.weeks.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 
    end

    # Act 
    travel_to 4.days.from_now do
      login_as(user)
      visit root_path
      click_on 'ABC121117'

      # Assert
      expect(page).to have_button 'Fazer um lance'
    end
  end
end