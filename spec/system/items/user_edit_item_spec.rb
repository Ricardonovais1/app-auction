require 'rails_helper'

describe 'Usuário edita produto' do 
  it 'com sucesso' do 
    prod_cat = ProductCategory.create!(name: 'Alguma')
    item = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8, width: 5, product_category_id: prod_cat.id )
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
  

    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
    within("#item_#{item.id}") do
      click_on 'Ver detalhes'
    end
    
    click_on 'Editar'
    fill_in 'Nome', with: 'Mouse exbom XP'
    fill_in 'Descrição', with: 'Mouse com fio com luz de LED azul'
    attach_file 'Imagem', Rails.root.join("spec/support/img/campus_code_logo.png")
    click_on 'Salvar'


    expect(page).to have_content 'Produto atualizado com sucesso'
    expect(page).to have_content 'Mouse exbom XP'
    expect(page).to have_content 'Mouse com fio com luz de LED azul'
    expect(page).to have_content 'Categoria: Alguma'
    expect(page).to have_content 'Peso: 100g'
    expect(page).to have_content 'Dimensões: 3cm (altura) x 8cm (profundidade) x 5cm (largura)' 
  end

  it 'só ser for admin' do
    prod_cat = ProductCategory.create!(name: 'Alguma')
    item = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8, width: 5, product_category_id: prod_cat.id )
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
  

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
    within("#item_#{item.id}") do
      click_on 'Ver detalhes'
    end

    expect(page).not_to have_button 'Editar'
  end
end