require 'rails_helper'

describe 'Usuário responde pergunta no lote' do 
  it 'só se for admin' do 
    # Arrange 
    admin = User.create!(name: 'Fernanda', email: 'fernanda@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    user = User.create!(name: 'Sérgio', email: 'sergio@exemplo.com.br', registration_number: '87451252019', password: 'password') 
    lot = Lot.create!(code: 'ABC123987', start_date: 1.days.from_now, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Fernanda', by_email: 'fernanda@leilaodogalpao.com.br',
                      status: :approved)
    
    # Act 
    travel_to Time.current + 2.days do  
      login_as(user)
      visit root_path
      click_on "ABC123987"

      question = Question.create!(body: "É possível fazer um lance e ainda hoje? Obrigado!", lot_id: lot.id, user_id: user.id)
    
    # Assert 
    expect(page).not_to have_field 'Responda aqui'
    expect(page).not_to have_button 'Responder'
    expect(page).not_to have_link 'Ocultar'
    end
  end
end