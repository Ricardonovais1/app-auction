# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário Admin adiciona novo item ao lote' do
  it 'só se estiver logado' do
    lot = Lot.create!(code: 'ABC123987', start_date: 2.day.from_now, limit_date: 1.week.from_now,
                      minimum_bid_value: 100, minimum_bid_difference: 10,
                      by: 'Ana', by_email: 'ana@leilaodogalpao.com.br')

    visit new_lot_lot_item_path(lot.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar esta página'
  end

  it 'só se for admin' do
    # Arrange
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607',
                        password: 'password')
    lot = Lot.create!(code: 'ABC123987', start_date: 2.day.from_now, limit_date: 1.week.from_now,
                      minimum_bid_value: 100, minimum_bid_difference: 10,
                      by: 'Ana', by_email: 'ana@leilaodogalpao.com.br')
    # Act
    login_as user
    visit new_lot_lot_item_path(lot.id)

    # Assert
    expect(page).to have_content 'Você não tem permissão para acessar esta página'
    expect(current_path).to eq root_path
  end

  it 'com sucesso' do
    # Arrange
    admin = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')
    lot = Lot.create!(code: 'ABC123987', start_date: 2.day.from_now, limit_date: 1.week.from_now,
                      minimum_bid_value: 100, minimum_bid_difference: 10,
                      by: 'Ana', by_email: 'ana@leilaodogalpao.com.br')
    prod_cat = ProductCategory.create!(name: 'Alguma')
    Item.create!(name: 'Mouse exbom', description: 'Mouse com fio',
                 weight: 100, height: 3, depth: 8, width: 5,
                 product_category_id: prod_cat.id)

    # Act
    login_as admin
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
    expect(current_path).to eq lot_path(lot.id)
    expect(page).to have_content 'Mouse exbom'
  end

  it 'e vê detalhes do produto a partir do lote' do
    # Arrange
    admin = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')
    Lot.create!(code: 'ABC123987', start_date: 2.day.from_now, limit_date: 1.week.from_now,
                minimum_bid_value: 100, minimum_bid_difference: 10,
                by: 'Ana', by_email: 'ana@leilaodogalpao.com.br')
    prod_cat = ProductCategory.create!(name: 'Alguma')
    item = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio',
                        weight: 100, height: 3, depth: 8, width: 5,
                        product_category_id: prod_cat.id)

    # Act
    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'ABC123987'
    click_on 'Adicionar item'
    select 'Mouse exbom', from: 'Produto'
    click_on 'Gravar'
    click_on 'Detalhes'

    # Assert
    expect(current_path).to eq item_path(item.id)
    expect(page).to have_content 'Mouse exbom'
    expect(page).to have_content 'Descrição: Mouse com fio'
    expect(page).to have_content 'Peso: 100g'
    expect(page).to have_content 'Dimensões: 3cm (altura) x 8cm (profundidade) x 5cm (largura)'
    expect(page).to have_content "Código: #{item.code}"
  end

  # it 'E vê mensagem de erro se não selecionar nenhum ítem' do
  #   # Arrange
  #   admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
  #   lote = Lot.create!(code: 'ABC123987', start_date: 2.day.from_now, limit_date: 1.week.from_now,
  #                     minimum_bid_value: 100, minimum_bid_difference: 10,
  #                     by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')
  #   prod_cat = ProductCategory.create!(name: 'Alguma')
  #   item = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio',
  #                       weight: 100, height: 3, depth: 8, width: 5,
  #                       product_category_id: prod_cat.id )

  #   # Act
  #   login_as admin
  #   visit root_path
  #   within('nav') do
  #     click_on 'Administrativo'
  #     click_on 'Lotes pendentes'
  #   end
  #   click_on 'ABC123987'
  #   click_on 'Adicionar item'
  #   click_on 'Gravar'

  #   # Assert
  #   expect(page).to have_content 'Você não selecionou nenhum item'
  #   expect(current_path).to eq new_lot_lot_item_path(lote)
  # end

  it 'só se for o autor do lote (proteção de rota)' do
    # Arrange
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')
    lote = Lot.create!(code: 'ABC123987', start_date: 2.day.from_now, limit_date: 1.week.from_now,
                       minimum_bid_value: 100, minimum_bid_difference: 10,
                       by: 'Ana', by_email: 'ana@leilaodogalpao.com.br')
    prod_cat = ProductCategory.create!(name: 'Alguma')
    Item.create!(name: 'Mouse exbom', description: 'Mouse com fio',
                 weight: 100, height: 3, depth: 8, width: 5,
                 product_category_id: prod_cat.id)

    # Act
    login_as admin
    visit new_lot_lot_item_path(lote)

    expect(current_path).to eq lot_path(lote)
    expect(page).to have_content 'Apenas o criador do lote pode adicionar ítens'
  end

  it 'e retorna para o lote através de um botão' do
    # Arrange
    admin = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')
    lote = Lot.create!(code: 'ABC123987', start_date: 2.day.from_now, limit_date: 1.week.from_now,
                       minimum_bid_value: 100, minimum_bid_difference: 10,
                       by: 'Ana', by_email: 'ana@leilaodogalpao.com.br')
    prod_cat = ProductCategory.create!(name: 'Alguma')
    Item.create!(name: 'Mouse exbom', description: 'Mouse com fio',
                 weight: 100, height: 3, depth: 8, width: 5,
                 product_category_id: prod_cat.id)

    # Act
    login_as admin
    visit new_lot_lot_item_path(lote)
    click_on 'Voltar para o lote'

    expect(current_path).to eq lot_path(lote)
  end
end
