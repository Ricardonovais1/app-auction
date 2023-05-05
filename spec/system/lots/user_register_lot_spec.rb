require 'rails_helper'

describe 'usuário admin cadastra lote' do
  it 'a partir do menu' do 
    # Arrange 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

    # Act 
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Criar lote'
    end

    # Assert
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Data de início'
    expect(page).to have_field 'Data limite para lances'
    expect(page).to have_field 'Valor mínimo para lance'
    expect(page).to have_field 'Menor diferença permitida entre lances'
  end

  it 'com sucesso' do 
    # Arrange 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

    # Act 
    login_as(admin)
    visit root_path 
    within('nav') do
      click_on 'Criar lote'
    end
    fill_in 'Código', with: 'DKP111222'
    fill_in 'Data de início', with: '20/12/2029'
    fill_in 'Data limite para lances', with: '20/01/2030'
    fill_in 'Valor mínimo para lance', with: '100'
    fill_in 'Menor diferença permitida entre lances', with: '10'
    click_on 'Cadastrar lote'

    # Assert
    expect(current_path).to eq lot_path(Lot.last)
    expect(page).to have_content 'Código: DKP111222'
    expect(page).to have_content 'Data de início: 20/12/2029'
    expect(page).to have_content 'Data limite para lances: 20/01/2030'
    expect(page).to have_content 'Valor mínimo para lance: R$100,00'
    expect(page).to have_content 'Menor diferença permitida entre lances: R$10,00'
    expect(page).to have_content 'Criado por: Ricardo | ricardo@leilaodogalpao.com.br'
  end
end

       