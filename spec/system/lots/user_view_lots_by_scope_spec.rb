# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário visualiza lotes' do
  context 'em andamento e futuros' do
    it 'na página inicial' do
      # Arrange
      Lot.create!(code: 'AAA101010', start_date: '2090-10-20', limit_date: '2090-10-30',
                  minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved)

      travel_to 1.week.ago do
        past_lot = Lot.create!(code: 'CCC131313', start_date: 2.day.from_now, limit_date: 5.day.from_now,
                               minimum_bid_value: 300, minimum_bid_difference: 30)
        past_lot.save(validate: false)
      end

      Lot.create!(code: 'BBB131212', start_date: 2.day.from_now, limit_date: 1.month.from_now,
                  minimum_bid_value: 200, minimum_bid_difference: 20, status: :approved)

      # Act
      visit root_path

      # Assert
      expect(page).to have_content 'AAA101010'
      expect(page).to have_content 'BBB131212'
      expect(page).not_to have_content 'CCC131313'
    end
  end

  context 'expirados' do
    it 'e precisa estar logado' do
      travel_to Time.current - 2.months do
        Lot.create!(code: 'CCC131313', start_date: 2.days.from_now, limit_date: 1.week.from_now,
                    minimum_bid_value: 300, minimum_bid_difference: 30)
      end

      visit expired_lots_path

      expect(current_path).to eq new_user_session_path
    end

    it 'e precisa estar logado como admin' do
      travel_to Time.current - 2.months do
        Lot.create!(code: 'CCC131313', start_date: 2.days.from_now, limit_date: 1.week.from_now,
                    minimum_bid_value: 300, minimum_bid_difference: 30)
      end
      user = User.create!(name: 'Ricardo', email: 'ricardo@algumservidor.com.br', registration_number: '70535073607',
                          password: 'password')

      login_as(user)
      visit expired_lots_path

      expect(current_path).to eq root_path
      expect(page).to have_content 'Você não tem permissão para acessar esta página'
    end

    it 'pelo menu' do
      # Arrange
      travel_to Time.current - 2.months do
        Lot.create!(code: 'CCC131313', start_date: 2.days.from_now, limit_date: 1.week.from_now,
                    minimum_bid_value: 300, minimum_bid_difference: 30)
      end
      admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br',
                           registration_number: '70535073607', password: 'password')

      login_as(admin)
      visit root_path
      within('nav') do
        click_on 'Administrativo'
        click_on 'Lotes expirados'
      end

      expect(page).to have_content 'CCC131313'
    end

    it 'na página de lotes expirados' do
      Lot.create!(code: 'AAA101010', start_date: '2090-10-20', limit_date: '2090-10-30',
                  minimum_bid_value: 100, minimum_bid_difference: 10)

      travel_to Time.current - 10.days do
        past_lot = Lot.create!(code: 'CCC131313', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                               minimum_bid_value: 300, minimum_bid_difference: 30)
        past_lot.save(validate: false)
      end

      travel_to Time.current - 3.days do
        Lot.create!(code: 'BBB121212', start_date: 2.days.from_now, limit_date: 1.week.from_now,
                    minimum_bid_value: 200, minimum_bid_difference: 20)
        admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br',
                             registration_number: '70535073607', password: 'password')

        login_as(admin)
        visit expired_lots_path

        expect(page).not_to have_content 'AAA101010'
        expect(page).not_to have_content 'BBB121212'
        expect(page).to have_content 'CCC131313'
      end
    end

    it 'e lotes expirados não possuem opção de adicionar item nem de serem aprovados' do
      admin = User.create!(name: 'Alice', email: 'alice@leilaodogalpao.com.br',
                           registration_number: '70535073607', password: 'password')
      travel_to Time.current - 2.months do
        Lot.create!(code: 'CCC131313', start_date: 1.month.from_now, limit_date: 6.weeks.from_now,
                    minimum_bid_value: 300, minimum_bid_difference: 30,
                    by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')
      end

      login_as(admin)
      visit expired_lots_path
      click_on 'CCC131313'

      expect(page).not_to have_content 'Adicionar item'
      expect(page).not_to have_button 'Aprovar lote'
      expect(page).not_to have_content 'Valor mínimo para lance atual'
      expect(page).not_to have_button 'Fazer um lance a partir de'
      expect(page).to have_content 'Lote expirado'
    end

    it 'e lote expirado sem nenhum lance aparece como cancelado' do
      admin = User.create!(name: 'Alice', email: 'alice@leilaodogalpao.com.br',
                           registration_number: '70535073607', password: 'password')
      travel_to Time.current - 2.months do
        Lot.create!(code: 'CCC131313', start_date: 1.month.from_now, limit_date: 6.weeks.from_now,
                    minimum_bid_value: 300, minimum_bid_difference: 30,
                    by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')
      end

      login_as(admin)
      visit expired_lots_path
      click_on 'CCC131313'

      expect(page).not_to have_content 'Adicionar item'
      expect(page).not_to have_button 'Aprovar lote'
      expect(page).not_to have_content 'Valor mínimo para lance atual'
      expect(page).not_to have_button 'Fazer um lance a partir de'
      expect(page).to have_content 'Lote expirado'
      expect(page).to have_content 'Cancelado por falta de lances'
      within('main') do
        expect(page).not_to have_content 'Arrematante'
      end
    end
  end

  context 'pendentes' do
    it 'na página de lotes pendentes' do
      admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br',
                           registration_number: '70535073607', password: 'password')
      Lot.create!(code: 'AAA101010', start_date: '2090-10-20', limit_date: '2090-10-30',
                  minimum_bid_value: 100, minimum_bid_difference: 10)
      Lot.create!(code: 'ABC191919', start_date: '2090-10-20', limit_date: '2090-10-30',
                  minimum_bid_value: 100, minimum_bid_difference: 10)

      login_as(admin)
      visit root_path
      within('nav') do
        click_on 'Administrativo'
        click_on 'Lotes pendentes'
      end

      expect(page).to have_content 'Lotes pendentes'
      expect(page).to have_content 'AAA101010'
      expect(page).to have_content 'ABC191919'
    end
  end
end
