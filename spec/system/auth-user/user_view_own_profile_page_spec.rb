require 'rails_helper'

describe 'Usuário visualiza seu próprio perfil' do 
  it 'a partir do menu' do 
    user = User.create!(name: 'Ricardo', email: 'ricardo@qualquerprovedor.com.br', registration_number: '70535073607', password: 'password')
     
    login_as user
    visit root_path
    within('nav') do 
      click_on 'Meu perfil'
    end

    expect(page).to have_content 'Meu perfil'
    expect(page).to have_content 'Ricardo'
    expect(page).to have_content 'Email: ricardo@qualquerprovedor.com.br'
    expect(page).to have_content 'CPF: 70535073607'
  end
end