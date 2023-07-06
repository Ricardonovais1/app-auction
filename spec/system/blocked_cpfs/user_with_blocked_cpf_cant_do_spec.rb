# frozen_string_literal: true

require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Usuário com CPF bloqueado não consegue' do
  it 'fazer um lance' do
    user = User.create!(name: 'Fernanda', email: 'fernanda@exemplo.com.br', registration_number: '14964827003',
                        password: 'password')
    BlockedCpf.create!(cpf: '14964827003', blocked: true)
    travel_to 2.days.ago do
      Lot.create!(code: 'ABC121117', start_date: 3.day.from_now, limit_date: 1.week.from_now,
                  minimum_bid_value: 100, minimum_bid_difference: 10,
                  by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br', status: :approved)
    end

    travel_to 4.days.from_now do
      login_as user
      visit root_path
      click_on 'ABC121117'
      click_on 'Fazer um lance a partir de R$100,00'

      expect(page).to have_content 'CPF bloqueado. Lance não permitido'
    end
  end
end
