# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário cria sua conta' do
  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Ricardo'
    fill_in 'CPF', with: '70535073607'
    fill_in 'Email', with: 'ric@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    attach_file 'Imagem', Rails.root.join('spec/support/img/homem_3.jpeg')
    click_on 'Cadastrar'

    # Assert

    expect(page).to have_content 'Ótimo! Você realizou seu registro com sucesso.'
    within('nav') do
      expect(page).not_to have_content 'Entrar'
      expect(page).not_to have_content 'Criar lote'
      expect(page).to have_content 'Sair'
      expect(page).to have_content 'ric@email.com'
    end
  end

  it 'como admin' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Ricardo'
    fill_in 'CPF', with: '70535073607'
    fill_in 'Email', with: 'ric@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Ótimo! Você realizou seu registro com sucesso.'
    within('nav') do
      expect(page).not_to have_content 'Entrar'
      expect(page).to have_content 'Criar lote'
      expect(page).to have_content 'Sair'
      expect(page).to have_content 'ric@leilaodogalpao.com.br'
    end
  end
end
