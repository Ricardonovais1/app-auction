require 'rails_helper'

describe 'Usuário faz login' do 
  it 'com sucesso' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com', registration_number: '70535073607', password: 'password')
    
    # Act 
    visit root_path
    within('nav') do
      click_on 'Entrar'
    end      
    fill_in 'Email', with: 'ricardo@amigoviolao.com'
    fill_in 'Senha', with: 'password'
    within('.actions') do
      click_on 'Entrar'
    end    
    
    # Assert 
    within('nav') do 
      expect(page).not_to have_content 'Entrar/ Cadastrar'
      expect(page).to have_content 'Sair'
      expect(page).to have_content user.email
    end 
  end

  it 'e faz logout' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com', registration_number: '70535073607', password: 'password')

    # Act 
    visit root_path 
    click_on 'Entrar'
    fill_in 'Email', with: 'ricardo@amigoviolao.com'
    fill_in 'Senha', with: 'password'
    within('.actions') do 
      click_on 'Entrar'
    end
    within('.sair') do 
      click_on 'Sair'
    end

    # Assert
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_link 'Sair'
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_content 'ricardo@amigoviolao.com | Olá Ricardo!'
  end

  it 'e não vê botão de Criar lote' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@rock.com.br', registration_number: '70535073607', password: 'password')

    # Act 
    login_as(user)
    visit root_path

    # Assert
    expect(page).not_to have_link 'Criar lote'
  end
end