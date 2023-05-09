require 'rails_helper'

describe 'Usuário visualiza produtos cadastrados' do 
  it 'se estiver autenticado' do 
    visit items_path

    expect(current_path).to eq new_user_session_path
  end 

  it 'se estiver autenticado como admin' do 
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com', registration_number: '70535073607', password: 'password')

    login_as(user)
    visit items_path

    expect(page).to have_content 'Você não tem permissão para acessar esta página'
    expect(current_path).to eq root_path
  end 

  it 'se estiver autenticado como admin' do 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

    login_as(admin)
    visit items_path

    expect(current_path).to eq items_path
    expect(page).to have_content 'Produtos cadastrados'
  end 

  it 'com sucesso' do 
    # Arrange 
    prod_cat = ProductCategory.create!(name: 'Alguma')
    item = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, width: 5, height: 3, depth: 8, product_category_id: prod_cat.id )
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