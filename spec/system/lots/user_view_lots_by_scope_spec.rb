require 'rails_helper'

describe 'Usuário visualiza lotes' do 
  context 'em andamento e futuros' do 
    it 'na página inicial' do 
      # Arrange 
      future_lot = Lot.create!(code: 'AAA101010', start_date: '2090-10-20', limit_date: '2090-10-30', 
                               minimum_bid_value: 100, minimum_bid_difference: 10, status: :approved)
      
      current_lot = Lot.create!(code: 'BBB131212', start_date: 1.day.ago, limit_date: 1.year.from_now, 
                                minimum_bid_value: 200, minimum_bid_difference: 20)
      
      past_lot = Lot.create!(code: 'CCC131313', start_date: 1.month.ago, limit_date: 1.week.ago, 
                                minimum_bid_value: 300, minimum_bid_difference: 30)

      # Act 
      visit root_path

      # Assert 
      expect(page).to have_content 'AAA101010'
      expect(page).not_to have_content 'BBB131212'
      expect(page).not_to have_content 'CCC131313'
    end
  end

  context 'expirados' do 
    it 'e precisa estar logado' do 
      past_lot = Lot.create!(code: 'CCC131313', start_date: 1.month.ago, limit_date: 1.week.ago, 
                             minimum_bid_value: 300, minimum_bid_difference: 30)
      
      visit expired_lots_path

      expect(current_path).to eq new_user_session_path
    end 

    it 'e precisa estar logado como admin' do 
      past_lot = Lot.create!(code: 'CCC131313', start_date: 1.month.ago, limit_date: 1.week.ago, 
                             minimum_bid_value: 300, minimum_bid_difference: 30)
      user = User.create!(name: 'Ricardo', email: 'ricardo@algumservidor.com.br', registration_number: '70535073607', password: 'password')

      login_as(user)
      visit expired_lots_path

      expect(current_path).to eq root_path
      expect(page).to have_content 'Você não tem permissão para acessar esta página'
    end 

    it 'pelo menu' do 
      # Arrange 
      past_lot = Lot.create!(code: 'CCC131313', start_date: 1.month.ago, limit_date: 1.week.ago, 
                             minimum_bid_value: 300, minimum_bid_difference: 30)
      admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

      # Act 
      login_as(admin)
      visit root_path
      within('nav') do 
        click_on 'Administrativo'
        click_on 'Lotes expirados'
      end

      # Assert
      expect(page).to have_content 'CCC131313'
    end

    it 'na página de lotes expirados' do 
      # Arrange 
      future_lot = Lot.create!(code: 'AAA101010', start_date: '2090-10-20', limit_date: '2090-10-30', 
                               minimum_bid_value: 100, minimum_bid_difference: 10)

      current_lot = Lot.create!(code: 'BBB121212', start_date: 1.day.ago, limit_date: 1.week.from_now, 
                                minimum_bid_value: 200, minimum_bid_difference: 20)

      past_lot = Lot.create!(code: 'CCC131313', start_date: 1.month.ago, limit_date: 1.week.ago, 
                             minimum_bid_value: 300, minimum_bid_difference: 30)
      admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
        

      # Act 
      login_as(admin)
      visit expired_lots_path

      # Assert 
      expect(page).not_to have_content 'AAA101010'
      expect(page).not_to have_content 'BBB121212'
      expect(page).to have_content 'CCC131313'

    end
  end

  context 'pendentes' do
    it 'na página de lotes pendentes' do 
      admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

      future_lot_1 = Lot.create!(code: 'AAA101010', start_date: '2090-10-20', limit_date: '2090-10-30', 
                                  minimum_bid_value: 100, minimum_bid_difference: 10)
      future_lot_2 = Lot.create!(code: 'ABC191919', start_date: '2090-10-20', limit_date: '2090-10-30', 
                                  minimum_bid_value: 100, minimum_bid_difference: 10)  

      # Act 
      login_as(admin)
      visit root_path
      within('nav') do 
        click_on 'Administrativo'
        click_on 'Lotes pendentes'
      end

      # Assert
      expect(page).to have_content 'Lotes pendentes'
      expect(page).to have_content 'AAA101010'
      expect(page).to have_content 'ABC191919'
    end
  end
end