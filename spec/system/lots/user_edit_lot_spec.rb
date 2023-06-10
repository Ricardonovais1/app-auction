require 'rails_helper'

describe 'Usuário edita lote' do 
  it 'com sucesso' do 
    admin = User.create!(name: 'Rafael', email: 'rafael@leilaodogalpao.com.br', registration_number: '05182085087', password: 'password')
    lote = Lot.create!(code: 'LPF892645', start_date: 3.days.from_now, limit_date: 1.month.from_now,
                       minimum_bid_value: 1000, minimum_bid_difference: 50, 
                       by: 'Rafael', by_email: 'rafael@leilaodogalpao.com.br')
    
    login_as admin 
    visit root_path 
    within('nav') do 
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'LPF892645'
    click_on 'Editar lote'
    fill_in "Valor mínimo para lance", with: 1200
    fill_in "Menor diferença entre lances", with: 60
    click_on 'Salvar'

    expect(page).to have_content 'Lote atualizado com sucesso'
    expect(page).to have_content 'Código LPF892645'
    expect(page).to have_content 'Valor mínimo para lance inicial R$1200,00'
    expect(page).to have_content 'Menor diferença entre lances R$60,00'
    expect(page).to have_content 'Aguardando aprovação'
    expect(page).to have_content 'Criado por: Rafael | rafael@leilaodogalpao.com.br'
  end

  it 'só se estiver logado' do 
    lote = Lot.create!(code: 'LPF892645', start_date: 3.days.from_now, limit_date: 1.month.from_now,
      minimum_bid_value: 1000, minimum_bid_difference: 50, 
      by: 'Rafael', by_email: 'rafael@leilaodogalpao.com.br')

    visit edit_lot_path(lote.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'só se for admin' do 
    user = User.create!(name: 'Rafael', email: 'rafael@exemplo.com.br', registration_number: '05182085087', password: 'password')
    lote = Lot.create!(code: 'LPF892645', start_date: 3.days.from_now, limit_date: 1.month.from_now,
      minimum_bid_value: 1000, minimum_bid_difference: 50, 
      by: 'Rafael', by_email: 'rafael@leilaodogalpao.com.br')

    login_as user
    visit edit_lot_path(lote.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para acessar esta página'
  end

  it 'botão editar só aparece para admin' do 
    user = User.create!(name: 'Rafael', email: 'rafael@exemplo.com.br', registration_number: '05182085087', password: 'password')
    lote = Lot.create!(code: 'LPF892645', start_date: 3.days.from_now, limit_date: 1.month.from_now,
                        minimum_bid_value: 1000, minimum_bid_difference: 50, 
                        by: 'Rafael', by_email: 'rafael@leilaodogalpao.com.br', status: :approved)

    login_as user
    visit root_path
    click_on 'LPF892645'

    expect(current_path).to eq lot_path(lote.id)
    expect(page).not_to have_button 'Editar lote'
  end

  it 'botão editar desabilitado se lote estiver aprovado' do
    admin = User.create!(name: 'Rafael', email: 'rafael@leilaodogalpao.com.br', registration_number: '05182085087', password: 'password')
    lote = Lot.create!(code: 'LPF892645', start_date: 3.days.from_now, limit_date: 1.month.from_now,
                       minimum_bid_value: 1000, minimum_bid_difference: 50, 
                       by: 'Rafael', by_email: 'rafael@leilaodogalpao.com.br', status: :approved)
    
    login_as admin 
    visit root_path 
    click_on 'LPF892645'
    click_on 'Editar lote'

    expect(current_path).to eq lot_path(lote)
    expect(page).to have_content 'Lote já aprovado'
  end

  it 'lote já aprovado tem a rota protegida' do 
    admin = User.create!(name: 'Rafael', email: 'rafael@leilaodogalpao.com.br', registration_number: '05182085087', password: 'password')
    lote = Lot.create!(code: 'LPF892645', start_date: 3.days.from_now, limit_date: 1.month.from_now,
                       minimum_bid_value: 1000, minimum_bid_difference: 50, 
                       by: 'Rafael', by_email: 'rafael@leilaodogalpao.com.br', status: :approved)
    
    login_as admin
    visit edit_lot_path(lote.id)

    expect(current_path).to eq lot_path(lote)
    expect(page).to have_content 'Lote já aprovado'
  end

  it 'somente se for quem criou o lote' do
    admin_creator = User.create!(name: 'Rafael', email: 'rafael@leilaodogalpao.com.br', registration_number: '05182085087', password: 'password')
    admin_editor = User.create!(name: 'Sandra', email: 'sandra@leilaodogalpao.com.br', registration_number: '47782844029', password: 'password')
    lote = Lot.create!(code: 'LPF892645', start_date: 3.days.from_now, limit_date: 1.month.from_now,
                       minimum_bid_value: 1000, minimum_bid_difference: 50, 
                       by: 'Rafael', by_email: 'rafael@leilaodogalpao.com.br')
    login_as admin_editor
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes pendentes'
    end
    click_on 'LPF892645'
    click_on 'Editar lote'

    expect(current_path).to eq lot_path(lote)
    expect(page).to have_content 'Apenas o autor do lote pode editá-lo'
  end

  it 'somente se for quem criou o lote 2 (proteção do rota)' do
    admin_creator = User.create!(name: 'Rafael', email: 'rafael@leilaodogalpao.com.br', registration_number: '05182085087', password: 'password')
    admin_editor = User.create!(name: 'Sandra', email: 'sandra@leilaodogalpao.com.br', registration_number: '47782844029', password: 'password')
    lote = Lot.create!(code: 'LPF892645', start_date: 3.days.from_now, limit_date: 1.month.from_now,
                       minimum_bid_value: 1000, minimum_bid_difference: 50, 
                       by: 'Rafael', by_email: 'rafael@leilaodogalpao.com.br')
    login_as admin_editor
    visit edit_lot_path(lote)

    expect(current_path).to eq lot_path(lote)
    expect(page).to have_content 'Apenas o autor do lote pode editá-lo'
  end
end 