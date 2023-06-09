require 'rails_helper'

describe 'Admin bloqueia um cpf' do
  it 'chegando à página própria pelo menu' do 
    admin = User.create!(name: 'Fernanda', email: 'fernanda@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Bloquear CPF'
    end

    expect(page).to have_content 'Insira um cpf a ser bloqueado'
    expect(page).to have_field 'Somente números'
    expect(page).to have_button 'Gravar'
  end

  it 'e cpfs bloqueados aparecem na tela de cadastro' do 
    admin = User.create!(name: 'Fernanda', email: 'fernanda@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')

    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Bloquear CPF'
    end
    fill_in 'CPF', with: '14964827003'
    click_on 'Gravar'

    expect(page).to have_content 'CPF bloqueado com sucesso'
    expect(page).not_to have_content 'Ainda não há nenhum CPF bloqueado'
    expect(page).to have_content "CPF's bloqueados"
    expect(page).to have_content "14964827003"
  end

  it 'e usuário tenta criar conta com cpf bloqueado' do 
    admin = User.create!(name: 'Fernanda', email: 'fernanda@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    cpf_to_block = '14964827003'
    
    login_as admin
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Bloquear CPF'
    end
    fill_in 'CPF', with: cpf_to_block
    click_on 'Gravar'

    blocked_cpf = BlockedCpf.find_by(cpf: cpf_to_block)
    expect(blocked_cpf).not_to be_nil
    expect(blocked_cpf.blocked).to be true

    click_on 'Sair'
    within('nav') do 
      click_on 'Entrar/ Cadastrar'
    end
    click_on 'Criar conta'
    fill_in 'Email', with: "ariel@email.com.br"
    fill_in 'Nome', with: "Ariel"
    fill_in 'CPF', with: "14964827003"
    fill_in 'Senha', with: "password"
    fill_in 'Confirme sua senha', with: "password"
    click_on 'Cadastrar'
    
    expect(page).to have_content 'CPF está bloqueado'
  end
end
