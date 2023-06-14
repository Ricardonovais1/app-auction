# frozen_string_literal: true

require 'rails_helper'

describe 'Admin acessa página de cadastro de categoria de produto' do
  it 'e precisa estar logado' do
    visit root_path

    expect(page).not_to have_content 'Administrativo'
  end

  it 'e precisa estar logado como admin' do
    User.create!(name: 'Ricardo', email: 'ricardo@gmail.com',
                 registration_number: '70535073607', password: 'password')

    visit root_path

    expect(page).not_to have_content 'Administrativo'
  end

  it 'como admin' do
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br',
                         registration_number: '70535073607', password: 'password')

    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Categorias de produto'
    end

    expect(page).to have_content 'Nova categoria de produto'
  end

  it 'com sucesso' do
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br',
                         registration_number: '70535073607', password: 'password')

    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Categorias de produto'
    end
    fill_in 'Nome', with: 'Cosméticos'
    click_on 'Salvar'

    expect(page).to have_content 'Nova categoria de produto salva com sucesso'
  end

  it 'sem preencher nome' do
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br',
                         registration_number: '70535073607', password: 'password')

    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Categorias de produto'
    end
    fill_in 'Nome', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Houve um problema'
  end
end
