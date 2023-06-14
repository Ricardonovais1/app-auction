# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário retorna à página inicial' do
  it 'clicando em home no menu' do
    visit root_path
    within('nav') do
      click_on 'Home'
    end
    expect(current_path).to eq root_path
    expect(page).to have_content 'Lotes em andamento'
  end

  it 'clicando em home no título do site' do
    visit root_path
    within('nav') do
      click_on 'Logo do Site'
    end

    expect(current_path).to eq root_path
    expect(page).to have_content 'Lotes em andamento'
  end
end
