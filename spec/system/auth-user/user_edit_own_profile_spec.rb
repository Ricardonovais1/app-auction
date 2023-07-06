# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário edita seu perfil' do
  it 'com sucesso' do
    user = User.create!(name: 'Ricardo', email: 'ricardo@qualquerprovedor.com.br', registration_number: '70535073607',
                        password: 'password')

    login_as user
    visit root_path
    within('nav') do
      click_on 'Meu perfil'
    end
    click_on 'Editar perfil'
    fill_in 'Nome', with: 'Ricardo Miranda de Novais'
    fill_in 'Sobre mim', with: 'Natural de Belo Horizonte, gerente técnico da indústria de computadores XPTO'
    fill_in 'Senha atual', with: 'password'
    click_on 'Salvar'
    within('nav') do
      click_on 'Meu perfil'
    end

    within('nav') do
      expect(page).to have_content 'Olá Ricardo!'
    end
    expect(page).to have_content 'Nome: Ricardo Miranda de Novais'
    expect(page).to have_content 'Sobre: Natural de Belo Horizonte, gerente técnico da indústria de computadores XPTO'
  end
end
