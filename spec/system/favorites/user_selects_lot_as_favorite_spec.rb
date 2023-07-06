# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário seleciona um lote como favorito' do
  it 'com sucesso' do
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com.br',
                        registration_number: '83424992003', password: 'password')
    lote = Lot.create!(code: 'CPR131313', start_date: 2.day.from_now, limit_date: 5.day.from_now,
                       minimum_bid_value: 300, minimum_bid_difference: 30, status: 'approved')

    travel_to 3.days.from_now do
      login_as user
      visit lot_path(lote)
      click_on 'Marcar lote como favorito'

      expect(page).to have_content 'Lote CPR131313 adicionado aos favoritos'
      expect(page).not_to have_button 'Marcar lote como favorito'
    end
  end

  it 'e remove dos favoritos pela tela de detalhes do lote' do
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com.br',
                        registration_number: '83424992003', password: 'password')
    lote = Lot.create!(code: 'CPR131313', start_date: 2.day.from_now, limit_date: 5.day.from_now,
                       minimum_bid_value: 300, minimum_bid_difference: 30, status: 'approved')

    travel_to 3.days.from_now do
      login_as user
      visit lot_path(lote)
      click_on 'Marcar lote como favorito'
      click_on 'Remover dos favoritos'

      expect(page).to have_content 'Lote CPR131313 removido dos favoritos'
      expect(page).to have_button 'Marcar lote como favorito'
      expect(page).not_to have_button 'Remover dos favoritos'
    end
  end
end
