require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers


describe 'Usuário faz pegunta a respeito de um lote' do 
  it 'a partir da view show do lote' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    travel_to Time.current - 3.days do 
      lot = Lot.create!(code: 'ABC123987', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br',
                        status: :approved)
    end

    # Act 
    login_as(user)
    visit root_path
    click_on 'ABC123987'

    # Assert
    expect(page).to have_content 'Tem alguma dúvida?'
  end

  it 'com sucesso' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    travel_to Time.current - 3.days do 
      lot = Lot.create!(code: 'ABC123987', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br',
                        status: :approved)
    end
    # Act 
    login_as(user)
    visit root_path
    click_on 'ABC123987'
    fill_in 'Escreva aqui', with: "Este lote inclui o produto XPTO?"
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Sua pergunta foi enviada com sucesso'
    expect(page).to have_content "Este lote inclui o produto XPTO?"
    expect(page).to have_content "Usuário(a): Ricardo"
  end

  it 'clica enviar sem escrever nada' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@exemplo.com.br', registration_number: '70535073607', password: 'password')
    travel_to Time.current - 3.days do 
      lot = Lot.create!(code: 'ABC123987', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br',
                        status: :approved)
    end
    # Act 
    login_as(user)
    visit root_path
    click_on 'ABC123987'
    fill_in 'Escreva aqui', with: ""
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Mensagem muito curta...'
  end

  it 'a menos que o lote esteja expirado' do
    # Arrange 
    admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    travel_to Time.current - 2.months do
      lot = Lot.create!(code: 'ABC123987', start_date: 1.week.from_now, limit_date: 1.month.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')
    end
    # Act 
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Administrativo'
      click_on 'Lotes expirados'
    end
    click_on 'ABC123987'

    # Assert
    expect(page).not_to have_content 'Tem alguma dúvida?'
    expect(page).not_to have_field 'Escreva aqui'
    expect(page).not_to have_button 'Enviar'
  end

  it 'e recebe uma resposta' do
    admin = User.create!(name: 'Fernanda', email: 'fernanda@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    user = User.create!(name: 'Sérgio', email: 'sergio@exemplo.com.br', registration_number: '87451252019', password: 'password') 
    travel_to Time.current - 3.days do 
      lot = Lot.create!(code: 'ABC123987', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br',
                        status: :approved)
    
      question = Question.create!(body: "É possível fazer um lance e ainda hoje? Obrigado!", lot_id: lot.id, user_id: user.id)
    
      login_as(admin)
      visit root_path
      click_on "ABC123987"
      fill_in "Responda aqui", with: "É sim. boa sorte!"
      click_on "Responder"

      expect(page).to have_content "Resposta enviada com sucesso"
      expect(page).to have_content "Usuário(a): Sérgio"
      expect(page).to have_content "É possível fazer um lance e ainda hoje? Obrigado!"
      expect(page).to have_content "Admin: Fernanda"
      expect(page).to have_content "É sim. boa sorte!"
    end
  end

  it 'e só pode responder se for admin' do 
    admin = User.create!(name: 'Fernanda', email: 'fernanda@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    user = User.create!(name: 'Sérgio', email: 'sergio@exemplo.com.br', registration_number: '87451252019', password: 'password') 
    travel_to Time.current - 2.days do 
    lot = Lot.create!(code: 'ABC123987', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                      minimum_bid_value: 100, minimum_bid_difference: 10, 
                      by: 'Fernanda', by_email: 'fernanda@leilaodogalpao.com.br',
                      status: :approved)
    question = Question.create!(body: "É possível fazer um lance e ainda hoje? Obrigado!", lot_id: lot.id, user_id: user.id)
  
    login_as(user)
    visit root_path
    click_on "ABC123987"

    expect(page).to have_content 'É possível fazer um lance e ainda hoje? Obrigado!'
    expect(page).not_to have_content 'Escreva aqui'
    expect(page).not_to have_button 'Responder'
    end
  end

  it 'e admin pode ocultar uma pergunta por não cumprir regras do site' do
    admin = User.create!(name: 'Fernanda', email: 'fernanda@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    user = User.create!(name: 'Sérgio', email: 'sergio@exemplo.com.br', registration_number: '87451252019', password: 'password') 
    travel_to Time.current - 2.days do
      lot = Lot.create!(code: 'ABC123987', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Fernanda', by_email: 'fernanda@leilaodogalpao.com.br',
                        status: :approved)
      question = Question.create!(body: "É possível fazer um lance e ainda hoje? Obrigado!", lot_id: lot.id, user_id: user.id)
    
      login_as(admin)
      visit root_path
      click_on "ABC123987"
      click_on 'Ocultar'

      expect(page).to have_content 'Pergunta ocultada com sucesso'
      expect(page).to have_content "Usuário(a): Sérgio"
      expect(page).not_to have_content "É possível fazer um lance e ainda hoje? Obrigado!"
      expect(page).to have_content "Esta pergunta fere as normas do site"
      expect(page).not_to have_content 'Ocultar'
      expect(page).to have_content 'Tornar visível'
    end
  end

  it 'só admins pode ver links ocultar e tornar visível' do 
    admin = User.create!(name: 'Fernanda', email: 'fernanda@leilaodogalpao.com.br', registration_number: '70535073607', password: 'password')
    user = User.create!(name: 'Sérgio', email: 'sergio@exemplo.com.br', registration_number: '87451252019', password: 'password') 
    travel_to Time.current - 2.days do
      lot = Lot.create!(code: 'ABC123987', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Fernanda', by_email: 'fernanda@leilaodogalpao.com.br',
                        status: :approved)
    
      question = Question.create!(body: "É possível fazer um lance e ainda hoje? Obrigado!", lot_id: lot.id, user_id: user.id)
    
      login_as(user)
      visit root_path
      click_on "ABC123987"
      
      expect(page).to have_content "Usuário(a): Sérgio"
      expect(page).to have_content "É possível fazer um lance e ainda hoje? Obrigado!"
      expect(page).not_to have_content "Ocultar"
      expect(page).not_to have_content "Tornar visível"
    end
  end

  it 'a menos que seu CPF esteja bloqueado' do 
    user = User.create!(name: 'Sérgio', email: 'sergio@exemplo.com.br', registration_number: '87451252019', password: 'password') 
    blocked_cpf = BlockedCpf.create!(cpf: '87451252019', blocked: true) 
    travel_to Time.current - 2.days do
      lot = Lot.create!(code: 'ABC123987', start_date: 1.day.from_now, limit_date: 1.week.from_now, 
                        minimum_bid_value: 100, minimum_bid_difference: 10, 
                        by: 'Fernanda', by_email: 'fernanda@leilaodogalpao.com.br',
                        status: :approved)
    
      login_as user
      visit root_path
      click_on 'ABC123987'
      fill_in 'Escreva aqui', with: "Este lote inclui o produto XPTO?"
      click_on 'Enviar'

      expect(page).to have_content 'CPF bloqueado. Mensagens não permitidas'
    end
  end
end