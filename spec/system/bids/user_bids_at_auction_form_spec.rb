require 'rails_helper'

describe 'Usuário faz um lance' do 

  it 'e precisa estar logado' do 
    # Arrange 
    travel_to 2.days.ago do
      lot = Lot.create!(code: 'ABC121117', start_date: 3.day.from_now, limit_date: 2.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 
    end

    # Act 
    puts 2.day.ago
    visit root_path
    click_on 'ABC121117'
   
    # Assert
    expect(page).not_to have_button 'Fazer um lance'
    expect(page).to have_content "Lances para lotes ativos e usuários logados"
  end


  it 'mas primeiro visualiza o formulário de lance' do
    # Arrange 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '08967526075', password: 'password')
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 
  


      # Act 
    travel_to 4.days.from_now do
      login_as(user)
      visit root_path
      click_on 'ABC121117'
      click_on 'Fazer um lance'

      # Assert
      expect(page).to have_content 'Faça seu lance'
    end
  end

  it 'com sucesso' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 
  

    # Act 
    travel_to 4.days.from_now do
      login_as(user)
      visit root_path
      click_on 'ABC121117'
      click_on 'Fazer um lance'
      fill_in 'Valor', with: 200
      click_on 'Confirmar lance'

      # Assert
      expect(page).to have_content 'Lance realizado com sucesso.'
      expect(page).to have_content "Valor mínimo para lance atual: R$210,00"
      expect(page).to have_content "Fazer um lance a partir de R$210,00"  
    end
  end

  it 'e primeiro lance pode ser igual ou superior ao mínimo, sem levar em consideração a diferença mínima' do
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 
    
    # Act 
    travel_to 4.day.from_now do 
      login_as(user)
      visit root_path
      click_on 'ABC121117'
      click_on 'Fazer um lance'
      fill_in 'Valor', with: 105
      click_on 'Confirmar lance'

      # Assert
      expect(page).to have_content 'Lance realizado com sucesso.'
      expect(page).to have_content "Valor mínimo para lance atual: R$115,00"
    end
  end

  it 'lance é inferior ao lance mínimo' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    
    lot = Lot.create!(code: 'ABC121117', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved) 
  

    # Act 
    travel_to 4.days.from_now do
      login_as(user)
      visit root_path
      click_on 'ABC121117'
      click_on 'Fazer um lance'
      fill_in 'Valor', with: 90
      click_on 'Confirmar lance'

      # Assert
      expect(page).to have_content "Valor mínimo para lance atual: R$100,00"
      expect(page).to have_content "Fazer um lance a partir de R$100,00"
    end
  end
end