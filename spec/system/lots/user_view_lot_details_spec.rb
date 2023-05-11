require 'rails_helper'

describe 'Usuário vê a tela de detalhes do lote' do  

  it 'e visualiza informações adicionais' do 
    # Arrange 
    lot = Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30', 
                      minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved) 

    # Act 
    visit root_path
    within('.future') do
      click_on 'Lote AAA000000'
    end

    # Assert
    expect(page).to have_content 'Código: AAA000000'
    expect(page).to have_content "Data de início: 20/10/2090" 
    expect(page).to have_content "Data limite para lances: 30/10/2090" 
    expect(page).to have_content "Valor mínimo para lance: R$100,00"
    expect(page).to have_content "Menor diferença permitida entre lances: R$10,00"
  end

  it 'e volta para a tela inicial' do 
    # Arrange 
    lot = Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30', 
      minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved) 

    # Act 
    visit root_path
    within('.future') do
      click_on 'Lote AAA000000'
    end
    click_on "Tela inicial"

    # Assert
    expect(current_path).to eq root_path
  end

  it 'e não vê informações sobre admin que criou o lote' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@email.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30', 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 

    # Act 
    login_as(user)
    visit root_path
    within('.future') do
      click_on 'Lote AAA000000'
    end
    # Assert
    expect(page).to have_content 'Código: AAA000000'
    expect(page).to have_content "Data de início: 20/10/2090" 
    expect(page).to have_content "Data limite para lances: 30/10/2090" 
    expect(page).to have_content "Valor mínimo para lance: R$100,00"
    expect(page).to have_content "Menor diferença permitida entre lances: R$10,00"
    expect(page).not_to have_content 'Criado por: Ricardo | ricardo@leilaodogalpao.com.br'
  end

  it 'e vê itens do lote' do 
    # Arrange 
    prod_cat = ProductCategory.create!(name: 'Alguma')
    item_a = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8, width: 5, product_category_id: prod_cat.id)
    item_b = Item.create!(name: 'Teclado logitech', description: 'Teclado super mega plus', weight: 200, height: 3, depth: 16, width: 45, product_category_id: prod_cat.id)
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30', 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')
    LotItem.create!(item: item_a, lot: lot)
    LotItem.create!(item: item_b, lot: lot)
    
    # Act
    login_as(admin)
    visit root_path 
    within('nav') do 
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'AAA000000'

    # Assert
    expect(page).to have_content "Itens do lote"
    expect(page).to have_content "Mouse exbom - cód. #{item_a.code}"
    expect(page).to have_content "Teclado logitech - cód. #{item_b.code}"
  end
end