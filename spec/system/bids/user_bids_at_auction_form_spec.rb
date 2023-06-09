# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário faz um lance' do
  it 'só se não for admin' do
    # Arrange
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '08967526075',
                         password: 'password')
    User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607',
                 password: 'password')
    Lot.create!(code: 'ABC121117', start_date: 2.day.from_now, limit_date: 1.week.from_now,
                minimum_bid_value: 100, minimum_bid_difference: 10,
                by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved)

    # Act
    travel_to 4.days.from_now do
      login_as(admin)
      visit root_path
      click_on 'ABC121117'

      # Assert
      expect(page).not_to have_content 'Fazer um lance'
    end
  end

  it 'e precisa estar logado' do
    # Arrange
    travel_to 2.days.ago do
      Lot.create!(code: 'ABC121117', start_date: 3.day.from_now, limit_date: 2.week.from_now,
                  minimum_bid_value: 100, minimum_bid_difference: 10,
                  by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved)
    end

    # Act
    visit root_path
    click_on 'ABC121117'

    # Assert
    expect(page).not_to have_button 'Fazer um lance'
    expect(page).to have_content 'Lances para lotes ativos e usuários comuns logados'
  end

  it 'mas primeiro visualiza o formulário de lance' do
    # Arrange
    User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '08967526075',
                 password: 'password')
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607',
                        password: 'password')
    Lot.create!(code: 'ABC121117', start_date: 2.day.from_now, limit_date: 1.week.from_now,
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
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607',
                        password: 'password')
    Lot.create!(code: 'ABC121117', start_date: 2.day.from_now, limit_date: 1.week.from_now,
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
      expect(page).to have_content 'Valor mínimo para lance atual R$210,00'
      expect(page).to have_content 'Fazer um lance a partir de R$210,00'
    end
  end

  it 'e primeiro lance pode ser igual ou superior ao mínimo, sem levar em consideração a diferença mínima' do
    # Arrange
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607',
                        password: 'password')
    Lot.create!(code: 'ABC121117', start_date: 2.day.from_now, limit_date: 1.week.from_now,
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
      expect(page).to have_content 'Valor mínimo para lance atual R$115,00'
    end
  end

  it 'lance é inferior ao lance mínimo' do
    # Arrange
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607',
                        password: 'password')

    Lot.create!(code: 'ABC121117', start_date: 2.day.from_now, limit_date: 1.week.from_now,
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
      expect(page).to have_content 'Verifique os erros abaixo:'
      expect(page).to have_content 'Valor precisa ser maior que valor mínimo'
    end
  end

  it 'deixando valor vazio' do
    # Arrange
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607',
                        password: 'password')

    lot = Lot.create!(code: 'ABC121117', start_date: 2.day.from_now, limit_date: 1.week.from_now,
                      minimum_bid_value: 100, minimum_bid_difference: 10,
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved)

    # Act
    travel_to 4.days.from_now do
      login_as(user)
      visit root_path
      click_on 'ABC121117'
      click_on 'Fazer um lance'
      fill_in 'Valor', with: ''
      click_on 'Confirmar lance'

      # Assert
      expect(current_path).to eq lot_bids_path(lot.id)
      expect(page).to have_content 'Não foi possível realizar o lance.'
      expect(page).to have_content 'Valor não pode ficar em branco'
    end
  end
end
