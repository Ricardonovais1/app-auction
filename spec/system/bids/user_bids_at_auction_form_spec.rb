require 'rails_helper'

describe 'Usuário faz um lance' do 
  it 'e precisa estar logado' do 
    # Arrange 
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.ago, limit_date: 1.week.from_now, 
      minimum_bid_value: 100, minimum_bid_difference: 10, 
      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 

    # Act 
    visit root_path
    click_on 'Lote ABC121117'
    click_on 'Fazer um lance'

    # Assert
    expect(current_path).to eq new_user_session_path
  end


  it 'mas primeiro visualiza o formulário de lance' do
    # Arrange 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '08967526075', password: 'password')
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.ago, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 

    # Act 
    login_as(user)
    visit root_path
    click_on 'Lote ABC121117'
    click_on 'Fazer um lance'

    # Assert
    expect(page).to have_content 'Faça seu lance'
  end

  it 'com sucesso' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.ago, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 

    # Act 
    login_as(user)
    visit root_path
    click_on 'Lote ABC121117'
    click_on 'Fazer um lance'
    fill_in 'Valor', with: 200
    click_on 'Confirmar lance'

    # Assert
    expect(page).to have_content 'Lance realizado com sucesso.'
    expect(page).to have_content "Valor mínimo para lance atual: R$210,00"
    expect(page).to have_content "Fazer um lance a partir de R$210,00"
  end

  it 'e primeiro lance pode ser igual ou superior ao mínimo, sem levar em consideração a diferença mínima' do
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.ago, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 

    # Act 
    login_as(user)
    visit root_path
    click_on 'Lote ABC121117'
    click_on 'Fazer um lance'
    fill_in 'Valor', with: 105
    click_on 'Confirmar lance'

    # Assert
    expect(page).to have_content 'Lance realizado com sucesso.'
    expect(page).to have_content "Valor mínimo para lance atual: R$115,00"
  end

  it 'lance é inferior ao lance mínimo' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.ago, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 

    # Act 
    login_as(user)
    visit root_path
    click_on 'Lote ABC121117'
    click_on 'Fazer um lance'
    fill_in 'Valor', with: 90
    click_on 'Confirmar lance'

    # Assert
    expect(page).to have_content "Valor mínimo para lance atual: R$100,00"
    expect(page).to have_content "Fazer um lance a partir de R$100,00"
    # expect(page).to have_content 'Não foi possível realizar o lance.'
  end
end