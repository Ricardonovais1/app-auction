# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'false quando name está vazio' do
      u = User.new(name: '', email: 'ricardo@amigoviolao.com', registration_number: '70535074670', password: 'password')

      result = u.valid?

      expect(result).to eq false
    end

    it 'false quando email está vazio' do
      u = User.new(name: 'Ricardo', email: '', registration_number: '70535074670', password: 'password')

      result = u.valid?

      expect(result).to eq false
    end

    it 'false quando cpf está vazio' do
      u = User.new(name: 'Ricardo', email: '', registration_number: '', password: 'password')

      result = u.valid?

      expect(result).to eq false
    end

    it 'false quando CPF é inválido' do
      u = User.new(name: 'Ricardo', email: 'ricardo@amigoviolao.com', registration_number: '705350746',
                   password: 'password')

      result = u.valid?

      expect(result).to eq false
    end

    it 'falso quando CPF não inclui apenas números' do
      u = User.new(name: 'Ricardo', email: 'ricardo@amigoviolao.com', registration_number: '705.350.746-70',
                   password: 'password')

      result = u.valid?

      expect(result).to eq false
    end

    it 'admin true quando email termina em @leilaodogalpao.com.br' do
      admin = User.create!(name: 'Ricardo', email: 'ricardo@leilaodogalpao.com.br', registration_number: '92015867600',
                           password: 'password')

      result = admin.admin

      expect(result).to be true
    end
  end
end
