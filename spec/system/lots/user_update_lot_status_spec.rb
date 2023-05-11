require 'rails_helper'

describe 'Admin muda status do lote para ativo' do
  it 'com sucesso' do 
    # Arrange 
    admin_1 = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    admin_2 = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '98512692049', password: 'password')
    lot = Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30', 
                      minimum_bid_value: 100, minimum_bid_difference: 10, by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')
    
    # Act 
    login_as(admin_2)
    visit root_path
    within('nav') do 
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'ABC123987'
    click_on 'Aprovar lote'

    # Assert
    expect(page).to have_content 'Situação do lote: Ativo'
  end
end