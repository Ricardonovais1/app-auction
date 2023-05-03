require 'rails_helper'

describe 'Usuário visita a página inicial' do 
  it 'e vê a título da app' do 
    # Arrange 

    # Act 
    visit root_path

    # Assert
    expect(page).to have_content 'Leilões de Estoque'
  end

  it 'e vê lotes cadastrados' do 
    # Arrange 
    first_lot = Lot.create!(code: 'AAA000000', start_date: '2090-10-10', limit_date: '2090-10-20', 
                            minimum_bid_value: 100, minimum_bid_difference: 10) 
    second_lot = Lot.create!(code: 'BBB111111', start_date: '2090-10-20', limit_date: '2090-10-30', 
                            minimum_bid_value: 200, minimum_bid_difference: 20) 
    # Act 
    visit root_path
    
    # Assert
    expect(page).to have_content 'Lote AAA000000'
    expect(page).to have_content "Data de início: 2090-10-10" 
    expect(page).to have_content "Data limite para lances: 2090-10-20" 
    expect(page).to have_content "Valor mínimo para lance: R$100,00"
    expect(page).to have_content "Menor diferença permitida entre lances: R$10,00"

    expect(page).to have_content 'Lote BBB111111'
    expect(page).to have_content "Data de início: 2090-10-20" 
    expect(page).to have_content "Data limite para lances: 2090-10-30" 
    expect(page).to have_content "Valor mínimo para lance: R$200,00"
    expect(page).to have_content "Menor diferença permitida entre lances: R$20,00"
  end
end