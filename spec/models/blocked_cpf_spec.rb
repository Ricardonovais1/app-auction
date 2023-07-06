# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlockedCpf, type: :model do
  describe '#valid?' do
    it 'falso quando cpf está vazio' do
      cpf = BlockedCpf.new(cpf: '')

      result = cpf.valid?

      expect(result).to eq false
    end
  end
end
