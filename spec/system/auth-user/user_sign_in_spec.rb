require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'com sucesso' do 
    # Arrange 
    user = User.create!(email: 'ricardo@algumacoisa.com', password: 'password')
    
    # Act 
    visit root_path
    within('nav') do
      click_on 'Entrar'
    end      
    fill_in 'Email', with: 'ricardo@algumacoisa.com'
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
end