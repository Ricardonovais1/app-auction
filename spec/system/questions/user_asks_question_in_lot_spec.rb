require 'rails_helper'

describe 'Usuário faz pegunta a respeito de um lote' do 
  it 'a partir da view show do lote' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC123987', start_date: 1.day.ago, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br',
                      status: :approved)
    # Act 
    login_as(user)
    visit root_path
    click_on 'ABC123987'

    # Assert
    expect(page).to have_content 'Tem alguma dúvida?'
  end

  it 'com sucesso' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC123987', start_date: 1.day.ago, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br',
                      status: :approved)
    # Act 
    login_as(user)
    visit root_path
    click_on 'ABC123987'
    fill_in 'Escreva aqui', with: "Este lote inclui o produto XPTO?"
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Sua pergunta foi enviada com sucesso'
    expect(page).to have_content "Este lote inclui o produto XPTO?"
  end

  it 'clica enviar sem escrever nada' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC123987', start_date: 1.day.ago, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br',
                      status: :approved)
    # Act 
    login_as(user)
    visit root_path
    click_on 'ABC123987'
    fill_in 'Escreva aqui', with: ""
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Mensagem muito curta...'
  end
end