require 'rails_helper'

describe 'Usuário visualiza produtos cadastrados' do 
  it 'com sucesso' do 
    # Arrange 
    item = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, width: 5, height: 3, depth: 8 )
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

    # Act 
    login_as(admin)
    visit root_path
    within('nav') do 
      click_on 'Administrativo'
      click_on 'Produtos cadastrados'
    end

    # Assert 
    expect(page).to have_content 'Mouse exbom'
  end
end