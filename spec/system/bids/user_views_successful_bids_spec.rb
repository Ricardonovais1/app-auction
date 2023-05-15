require  'rails_helper'

describe 'Usuário visualiza lances vencedores' do 
  it 'através do menu' do 
    # Arrange 

    # Act
    visit root_path
    # Assert
    within('nav') do 
      expect(page).to have_content 'Arrematantes'
    end
  end

  it 'e precisa estar logado' do 
    # Arrange 

    # Act
    visit root_path
    within('nav') do
      click_on 'Arrematantes'
    end

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e visualiza a página' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', 
                        registration_number: '70535073607', password: 'password')

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Arrematantes'
    end

    # Assert
    expect(current_path).to eq successfull_bids_lots_path
    expect(page).to have_content 'Lances vencedores'
  end
end