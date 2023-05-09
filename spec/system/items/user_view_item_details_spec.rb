require 'rails_helper'

describe 'Usuário visualiza detalhes do produto' do 
  it 'se estiver autenticado' do 
    item = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8, width: 5 )
    user = User.create!(name: 'Ricardo', email: 'ricardo@qualquerprovedor.com.br', registration_number: '70535073607', password: 'password')
  
    login_as(user)
    visit item_path(item.id)

    expect(page).to have_content 'Produto: Mouse exbom'
    expect(page).to have_content 'Descrição: Mouse com fio'
    expect(page).to have_content 'Peso: 100g'
    expect(page).to have_content 'Dimensões: 3cm (altura) x 8cm (profundidade) x 5cm (largura)'
  end 


  it 'clicando no nome do produto' do 
    # Arrange 
    item = Item.create!(name: 'Mouse exbom', description: 'Mouse com fio', weight: 100, height: 3, depth: 8, width: 5 )
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

    # Act 
    login_as(admin)
    visit root_path
    within('nav') do 
      click_on 'Administrativo'
      click_on 'Produtos cadastrados'
    end
    click_on 'Mouse exbom'

    # Assert
    expect(page).to have_content 'Produto: Mouse exbom'
    expect(page).to have_content 'Descrição: Mouse com fio'
    expect(page).to have_content 'Peso: 100g'
    expect(page).to have_content 'Dimensões: 3cm (altura) x 8cm (profundidade) x 5cm (largura)'
    expect(page).to have_content "Código: #{item.code}"
  end
end