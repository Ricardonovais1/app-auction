# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário visualiza produtos cadastrados' do
  it 'se estiver autenticado como admin' do
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')

    login_as(admin)
    visit items_path

    expect(current_path).to eq items_path
    expect(page).to have_content 'Produtos cadastrados'
  end

  it 'com sucesso' do
    # Arrange
    prod_cat = ProductCategory.create!(name: 'Alguma')
    Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, width: 5, height: 3, depth: 8,
                 product_category_id: prod_cat.id)
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')

    # Act
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Produtos'
    end

    # Assert
    expect(page).to have_content 'Mouse exbom'
  end

  it 'e não há produtos cadastrados' do
    # Arrange
    Item.destroy_all

    # Act
    visit root_path
    click_on 'Produtos'

    # Assert
    expect(page).to have_content 'Não há produtos cadastrados'
  end

  # it 'por categoria' do
  #   # Arrange
  #   prod_cat_a = ProductCategory.create!(name: 'Alguma')
  #   prod_cat_b = ProductCategory.create!(name: 'Outra')
  #   prod_cat_c = ProductCategory.create!(name: 'Terceira')
  #   item_a = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio',
  #                       weight: 100, width: 5, height: 3, depth: 8,
  #                       product_category_id: prod_cat_a.id )
  #   item_b = Item.create!(name: 'Teclado logitech', description: 'Teclado honesto',
  #                       weight: 100, width: 5, height: 3, depth: 8,
  #                       product_category_id: prod_cat_b.id )
  #   item_c = Item.create!(name: 'Computador Dell', description: 'Excelente PC',
  #                       weight: 100, width: 5, height: 3, depth: 8,
  #                       product_category_id: prod_cat_c.id )
  #   # Act
  #   visit root_path
  #   within('nav') do
  #     click_on "Produtos cadastrados"
  #   end

  #   # Assert
  #   expect(page).to have_content 'Alguma'
  #   expect(page).to have_content 'Outra'
  #   expect(page).to have_content 'Terceira'

  # end
end
