require 'rails_helper'

describe 'Usuário vê a tela de detalhes do lote' do 
  it 'e visualiza informações adicionais' do 
    # Arrange 
    lot = Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30', 
                      minimum_bid_value: 100, minimum_bid_difference: 10) 

    # Act 
    visit root_path
    click_on 'Lote AAA000000'

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
      minimum_bid_value: 100, minimum_bid_difference: 10) 

    # Act 
    visit root_path
    click_on 'Lote AAA000000'
    click_on 'Tela inicial'

    # Assert
    expect(current_path).to eq root_path
  end
end