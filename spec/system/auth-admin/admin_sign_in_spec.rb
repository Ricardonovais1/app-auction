require 'rails_helper'

describe 'User Admin faz login' do 
  it 'com sucesso' do 
    # Arrange 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    
    # Act 
    login_as(admin)
    visit root_path  
    
    # Assert 
    within('nav') do 
      expect(page).not_to have_content 'Entrar/ Cadastrar'
      expect(page).to have_content 'Sair'
      expect(page).to have_content admin.email
    end 
  end
end