# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário cria um novo ítem' do
  it 'com sucesso' do
    # Arrange
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')
    ProductCategory.create!(name: 'Alguma')

    allow(SecureRandom).to receive(:alphanumeric).and_return('AXD45SIO87')
    # Act
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Novo produto'
    end
    fill_in 'Nome', with: 'Monitor HP'
    fill_in 'Descrição', with: 'Lindo monitor preto'
    fill_in 'Peso', with: 1500
    fill_in 'Altura', with: 45
    fill_in 'Profundidade', with: 20
    fill_in 'Largura', with: 60
    select 'Alguma', from: 'Categoria'
    attach_file 'Imagem', Rails.root.join('spec/support/img/campus_code_logo.png')
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Produto cadastrado com sucesso'
    expect(page).to have_content 'Monitor HP'
    expect(page).to have_content 'Categoria: Alguma'
    expect(page).to have_content 'Descrição: Lindo monitor preto'
    expect(page).to have_content 'Peso: 1500g'
    expect(page).to have_content 'Dimensões: 45cm (altura) x 20cm (profundidade) x 60cm (largura)'
    expect(page).to have_content 'Código: AXD45SIO87'
    expect(page).to have_css("img[src*='campus_code_logo']")
  end

  it 'sem preencher os campos' do
    # Arrange
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607',
                         password: 'password')

    allow(SecureRandom).to receive(:alphanumeric).and_return('AXD45SIO87')
    # Act
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Novo produto'
    end
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'Largura', with: ''
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
  end
end
