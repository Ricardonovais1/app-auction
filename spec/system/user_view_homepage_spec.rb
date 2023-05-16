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
    first_lot = Lot.create!(code: 'AAA000000', start_date: '08-10-2090', limit_date: '20-10-2090', 
                            minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved) 
    second_lot = Lot.create!(code: 'BBB111111', start_date: '05-06-2090', limit_date: '04-07-2090', 
                            minimum_bid_value: 200, minimum_bid_difference: 20, status: :approved) 
    # Act 
    visit root_path
    
    # Assert
    expect(page).to have_content 'AAA000000'
    expect(page).to have_content "08/10/2090 a 20/10/2090" 
    expect(page).to have_content 'BBB111111'
    expect(page).to have_content "05/06/2090 a 04/07/2090" 
  end

  it 'e não há lotes cadastrados' do 
    # Arrange 

    # Act 
    visit root_path

    # Assert
    expect(page).to have_content 'Nenhum lote cadastrado'
  end
end