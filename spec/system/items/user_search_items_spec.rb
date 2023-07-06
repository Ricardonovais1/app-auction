# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'e precisa estar logado' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Buscar'
    end

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    # Arrange
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br',
                        registration_number: '70535073607', password: 'password')

    # Act
    login_as(user)
    visit root_path

    # Assert
    within('nav') do
      expect(page).to have_button 'Buscar'
      expect(page).to have_field 'Buscar produto'
    end
  end

  it 'e encontra um produto pelo código' do
    # Arrange
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br',
                        registration_number: '70535073607', password: 'password')
    prod_cat = ProductCategory.create!(name: 'Alguma')
    item = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8, width: 5,
                        product_category_id: prod_cat.id)

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      fill_in 'Buscar produto', with: item.code
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content "Resultado da pesquisa para o termo '#{item.code}':"
    expect(page).to have_content '1 Produto encontrado'
    expect(page).to have_content 'Mouse exbom'
    expect(page).to have_content 'Mouse com fio'
  end

  it 'e encontra múltiplos produtos pelos código' do
    # Arrange
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br',
                        registration_number: '70535073607', password: 'password')

    prod_cat = ProductCategory.create!(name: 'Alguma')

    allow(SecureRandom).to receive(:alphanumeric).and_return('PAI1234567')
    Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8,
                 width: 5, product_category_id: prod_cat.id)

    allow(SecureRandom).to receive(:alphanumeric).and_return('PAI0987654')
    Item.create!(name: 'Teclado Logitech', description: 'Teclado preto muito bom', weight: 100, height: 3,
                 depth: 8, width: 5, product_category_id: prod_cat.id)

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      fill_in 'Buscar produto', with: 'PAI'
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content "Resultado da pesquisa para o termo 'PAI':"
    expect(page).to have_content '2 Produtos encontrados'
    expect(page).to have_content 'Mouse exbom'
    expect(page).to have_content 'Mouse com fio'
    expect(page).to have_content 'Teclado Logitech'
    expect(page).to have_content 'Teclado preto muito bom'
  end

  it 'e encontra múltiplos produtos pelos nome' do
    # Arrange
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br',
                        registration_number: '70535073607', password: 'password')

    prod_cat = ProductCategory.create!(name: 'Alguma')

    Item.create!(name: 'Teclado Zoom', description: 'Teclado sem fio', weight: 100, height: 3, depth: 8,
                 width: 5, product_category_id: prod_cat.id)

    Item.create!(name: 'Teclado Logitech', description: 'Teclado preto muito bom', weight: 100, height: 3,
                 depth: 8, width: 5, product_category_id: prod_cat.id)

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      fill_in 'Buscar produto', with: 'Teclado'
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content "Resultado da pesquisa para o termo 'Teclado':"
    expect(page).to have_content '2 Produtos encontrados'
    expect(page).to have_content 'Teclado Zoom'
    expect(page).to have_content 'Teclado sem fio'
    expect(page).to have_content 'Teclado Logitech'
    expect(page).to have_content 'Teclado preto muito bom'
  end
end
