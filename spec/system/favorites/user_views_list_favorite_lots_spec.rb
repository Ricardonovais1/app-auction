# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário visualiza lista de favoritos' do
  it 'na sua página de perfil' do
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com',
                        registration_number: '70535073607', password: 'password')
    lot_a = Lot.create!(code: 'CCC131313', start_date: 2.day.from_now, limit_date: 5.day.from_now,
                        minimum_bid_value: 300, minimum_bid_difference: 30)
    lot_b = Lot.create!(code: 'AAA101010', start_date: 3.day.from_now, limit_date: 1.week.from_now,
                        minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved)
    Favorite.create!(user_id: user.id, lot_id: lot_a.id)
    Favorite.create!(user_id: user.id, lot_id: lot_b.id)

    login_as user
    visit root_path
    within('nav') do
      click_on 'Meu perfil'
    end

    expect(page).to have_content 'Lotes favoritos'
    expect(page).to have_content "CCC131313 - Data limite: #{I18n.l(5.day.from_now, format: '%d/%m/%Y')}"
    expect(page).to have_content "AAA101010 - Data limite: #{I18n.l(1.week.from_now, format: '%d/%m/%Y')}"
  end

  it 'e não há nenhum favorito selecionado' do
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com',
                        registration_number: '70535073607', password: 'password')

    login_as user
    visit root_path
    within('nav') do
      click_on 'Meu perfil'
    end

    expect(page).to have_content 'Você não possui lotes marcados como favoritos'
  end

  it 'e clica no código do lote para acessar detalhes' do
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com',
                        registration_number: '70535073607', password: 'password')
    lote = Lot.create!(code: 'CCC131313', start_date: 2.day.from_now, limit_date: 5.day.from_now,
                       minimum_bid_value: 300, minimum_bid_difference: 30)
    Favorite.create!(user_id: user.id, lot_id: lote.id)

    login_as user
    visit root_path
    within('nav') do
      click_on 'Meu perfil'
    end
    click_on 'CCC131313'

    expect(current_path).to eq lot_path(lote)
    expect(page).to have_content 'Código CCC131313'
    expect(page).to have_content "Data de início #{I18n.l(lote.start_date)}"
  end
end
