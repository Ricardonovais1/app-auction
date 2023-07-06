# frozen_string_literal: true

require  'rails_helper'

describe 'Usuário visualiza lances vencedores' do
  it 'através do menu' do
    visit root_path

    within('nav') do
      expect(page).to have_content 'Arrematantes'
    end
  end

  it 'e precisa estar logado' do
    visit root_path
    within('nav') do
      click_on 'Arrematantes'
    end

    expect(current_path).to eq new_user_session_path
  end

  it 'e visualiza a página' do
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br',
                        registration_number: '70535073607', password: 'password')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Arrematantes'
    end

    expect(current_path).to eq successfull_bids_lots_path
    expect(page).to have_content 'Lances vencedores'
  end

  it 'e visualiza arrematantes' do
    user_a = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br',
                          registration_number: '70535073607', password: 'password')
    user_b = User.create!(name: 'Ana', email: 'ana@exemplo.com.br',
                          registration_number: '61973640007', password: 'password')
    user_c = User.create!(name: 'Marcos', email: 'marcos@exemplo.com.br',
                          registration_number: '00450794040', password: 'password')
    user_d = User.create!(name: 'Sarah', email: 'sarah@exemplo.com.br',
                          registration_number: '82485876061', password: 'password')

    lot_a = nil
    lot_b = nil

    travel_to 2.day.ago do
      lot_a = Lot.create!(code: 'AAA000000', start_date: 3.day.from_now, limit_date: 2.week.from_now,
                          minimum_bid_value: 300, minimum_bid_difference: 30, status: :ended)
      lot_b = Lot.create!(code: 'ZZZ111111', start_date: 3.day.from_now, limit_date: 2.week.from_now,
                          minimum_bid_value: 100, minimum_bid_difference: 10, status: :ended)
    end

    travel_to 4.days.from_now do
      Bid.create!(value: 500, lot_id: lot_a.id, user_id: user_a.id)
      Bid.create!(value: 600, lot_id: lot_a.id, user_id: user_b.id)

      Bid.create!(value: 789, lot_id: lot_b.id, user_id: user_c.id)
      Bid.create!(value: 999, lot_id: lot_b.id, user_id: user_d.id)
    end

    travel_to 3.weeks.from_now do
      login_as(user_a)
      visit root_path
      within('nav') do
        click_on 'Arrematantes'
      end

      expect(page).to have_content 'Ana'
      expect(page).to have_content 'AAA000000'
      expect(page).to have_content 'ana@exemplo.com.br'
      expect(page).to have_content 'R$600,00'
      expect(page).to have_content 'Sarah'
      expect(page).to have_content 'ZZZ111111'
      expect(page).to have_content 'sarah@exemplo.com.br'
      expect(page).to have_content 'R$999,00'
    end
  end
end
