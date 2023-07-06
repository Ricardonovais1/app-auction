# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário adiciona itens ao lote' do
  it 'com sucesso' do
    # Arrange
    prod_cat = ProductCategory.create!(name: 'Alguma')
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')
    item_a = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8,
                          width: 5, product_category_id: prod_cat.id)
    Item.create!(name: 'Teclado logitech', description: 'Teclado super mega plus', weight: 200, height: 3,
                 depth: 16, width: 45, product_category_id: prod_cat.id)
    Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
                minimum_bid_value: 100, minimum_bid_difference: 10,
                by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

    # Act
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'ABC123987'
    click_on 'Adicionar item'
    select 'Mouse exbom', from: 'Produto'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content "Mouse exbom - cód. #{item_a.code}"
  end

  it 'o mesmo item só pode ser adicionado uma vez' do
    # Arrange
    prod_cat = ProductCategory.create!(name: 'Alguma')
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')
    Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8,
                 width: 5, product_category_id: prod_cat.id)
    Item.create!(name: 'Teclado logitech', description: 'Teclado super mega plus', weight: 200, height: 3,
                 depth: 16, width: 45, product_category_id: prod_cat.id)
    Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
                minimum_bid_value: 100, minimum_bid_difference: 10,
                by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')
    # Act
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'ABC123987'
    click_on 'Adicionar item'
    select 'Mouse exbom', from: 'Produto'
    click_on 'Gravar'
    click_on 'Adicionar item'

    # Assert
    expect(page).not_to have_content 'Mouse exbom'
  end

  it 'e remove itens' do
    # Arrange
    prod_cat = ProductCategory.create!(name: 'Alguma')
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')
    Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8,
                 width: 5, product_category_id: prod_cat.id)
    Item.create!(name: 'Teclado logitech', description: 'Teclado super mega plus', weight: 200, height: 3,
                 depth: 16, width: 45, product_category_id: prod_cat.id)
    lot = Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
                      minimum_bid_value: 100, minimum_bid_difference: 10,
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')
    # Act
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'ABC123987'
    click_on 'Adicionar item'
    select 'Mouse exbom', from: 'Produto'
    click_on 'Gravar'
    within('.lot-items') do
      click_on 'Remover', match: :first
    end

    # Assert
    expect(current_path).to eq lot_path(lot.id)
    expect(page).not_to have_content 'Mouse exbom'
  end
end
