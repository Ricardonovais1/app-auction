# frozen_string_literal: true

require 'rails_helper'

describe 'Admin muda status do lote para ativo' do
  it 'e precisa estar logado para ver o botão' do
    # Arrange
    lot = Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
                      minimum_bid_value: 100, minimum_bid_difference: 10, by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')
    # Act
    visit lot_path(lot.id)

    # Assert
    expect(current_path).to eq lot_path(lot.id)
    expect(page).not_to have_button 'Aprovar lote'
    expect(page).not_to have_button 'Marcar como pendente'
  end

  it 'com sucesso' do
    # Arrange
    User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                 password: 'password')
    admin_2 = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '98512692049',
                           password: 'password')
    Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
                minimum_bid_value: 100, minimum_bid_difference: 10,
                by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

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
    expect(page).to have_content 'Situação Lote aprovado'
  end

  # it 'e botão de marcar pendente volta status para pendente de aprovação' do
  #   # Arrange
  #   admin_1 = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
  #   admin_2 = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '98512692049', password: 'password')
  #   lot = Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
  #                     minimum_bid_value: 100, minimum_bid_difference: 10, by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

  #   # Act
  #   login_as(admin_2)
  #   visit root_path
  #   within('nav') do
  #     click_on 'Administrativo'
  #     click_on 'Lotes pendentes'
  #   end
  #   click_on 'ABC123987'
  #   click_on 'Aprovar lote'
  #   click_on 'Marcar pendente'

  #   # Assert
  #   expect(page).to have_content 'Situação do lote: Aguardando aprovação'
  # end

  it 'e ao acessar a página de lote o admin só vê o botão Aprovar lote e não o Marcar pendente' do
    # Arrange
    User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                 password: 'password')
    admin_2 = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '98512692049',
                           password: 'password')
    Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
                minimum_bid_value: 100, minimum_bid_difference: 10,
                by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

    # Act
    login_as(admin_2)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'ABC123987'

    # Assert
    expect(page).to have_button 'Aprovar lote'
    expect(page).not_to have_button 'Marcar pendente'
  end

  it 'e só outro usuário admin pode aprovar o lote' do
    # Arrange
    admin_1 = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                           password: 'password')
    User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '98512692049',
                 password: 'password')
    Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
                minimum_bid_value: 100, minimum_bid_difference: 10, by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

    # Act
    login_as(admin_1)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'ABC123987'

    # Assert
    expect(page).not_to have_button 'Aprovar lote'
    expect(page).to have_content 'Situação Aguardando aprovação'
  end

  it 'e não é mais possível adicionar items ao lote' do
    # Arrange
    User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                 password: 'password')
    admin_2 = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '98512692049',
                           password: 'password')
    Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
                minimum_bid_value: 100, minimum_bid_difference: 10,
                by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

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
    expect(page).not_to have_content 'Aprovar lote'
    expect(page).not_to have_content 'Adicionar item'
  end

  it 'e aparece o nome e email do admin que aprovou o lote' do
    # Arrange
    User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                 password: 'password')
    admin_2 = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', registration_number: '98512692049',
                           password: 'password')
    Lot.create!(code: 'ABC123987', start_date: '2090-10-20', limit_date: '2090-10-30',
                minimum_bid_value: 100, minimum_bid_difference: 10,
                by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

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
    expect(page).to have_content "Aprovado por: #{admin_2.name} | #{admin_2.email}"
  end
end
