# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário visita página de lotes pendentes' do
  it 'sendo admin' do
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br',
                         registration_number: '70535073607', password: 'password')
    Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30',
                minimum_bid_value: 100, minimum_bid_difference: 10)
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end

    expect(page).to have_content 'AAA000000'
  end

  it 'e não consegue por não ser admin' do
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br',
                        registration_number: '70535073607', password: 'password')
    Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30',
                minimum_bid_value: 100, minimum_bid_difference: 10)
    login_as(user)
    visit pending_lots_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar esta página'
  end
end
