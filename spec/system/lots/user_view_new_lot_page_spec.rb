# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário vê página de criação de lote' do
  it 'se estiver logado' do
    visit new_lot_path

    expect(current_path).to eq new_user_session_path
  end

  it 'se estiver logado como admin' do
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com',
                        registration_number: '70535073607', password: 'password')

    login_as(user)
    visit new_lot_path

    expect(page).to have_content 'Você não tem permissão para acessar esta página'
    expect(current_path).to eq root_path
  end

  it 'se estiver logado como admin' do
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br',
                         registration_number: '70535073607', password: 'password')

    login_as(admin)
    visit new_lot_path

    expect(page).to have_content 'Criar um novo lote'
    expect(current_path).to eq new_lot_path
  end
end
