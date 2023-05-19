require 'rails_helper'

describe 'Usuário retorna à página inicial' do 
  it 'clicando em home no menu' do 
    # Arrange 

    # Act 
    visit root_path
    within('nav') do 
      click_on 'Home'
    end
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Lotes em andamento'
  end

  it 'clicando em home no título do site' do 
    # Arrange 

    # Act 
    visit root_path
    within('nav') do 
      click_on 'Logo do Site'
    end
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Lotes em andamento'
  end
end