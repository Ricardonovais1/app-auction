require 'rails_helper'

describe 'Admin acessa página de cadastro de categoria de produto' do 
  it 'e precisa estar logado' do 
    # Arrange 

    # Act 
    visit root_path 

    # Assert
    expect(page).not_to have_content 'Administrativo'
  end

  it 'e precisa estar logado como admin' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@gmail.com', registration_number: '70535073607', password: 'password')

    # Act 
    visit root_path 

    # Assert
    expect(page).not_to have_content 'Administrativo'
  end

  it 'como admin' do 
    # Arrange 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

    # Act 
    login_as(admin)
    visit root_path 
    within('nav') do
      click_on 'Administrativo'
      click_on 'Categorias de produto'
    end
  

    # Assert
    expect(page).to have_content 'Nova categoria de produto'
  end

  it 'com sucesso' do 
    # Arrange 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

    # Act 
    login_as(admin)
    visit root_path 
    within('nav') do
      click_on 'Administrativo'
      click_on 'Categorias de produto'
    end
    fill_in 'Nome', with: 'Cosméticos'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Nova categoria de produto salva com sucesso'
  end
  
  
  # it 'com sucesso' do 
  #   # Arrange 

  #   # Act 
  #   visit root_path
  #   within('nav') do 
  #     click_on 'Administrativo'
  #     click_on 'Categoria de produto'
  #   end  
  #   fill_in 'Nome', with: 'Informática'

  #   # Assert
  #   expect(page).to have_content 'Categoria salva com sucesso'
  # end
end