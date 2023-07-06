# frozen_string_literal: true

require 'rails_helper'

describe 'User Admin faz login' do
  it 'com sucesso' do
    # Arrange
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')

    # Act
    login_as(admin)
    visit root_path

    # Assert
    within('nav') do
      expect(page).not_to have_content 'Entrar/ Cadastrar'
      expect(page).to have_content 'Sair'
      expect(page).to have_content admin.email
    end
  end

  it 'e vê botão de criar lote' do
    # Arrange
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')

    # Act
    login_as(admin)
    visit root_path
    # Assert

    expect(page).to have_link 'Criar lote'
  end
end
