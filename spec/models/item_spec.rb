# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#valid?' do
    it 'falso quando nome está vazio' do
      item = Item.new(name: '', description: 'Alguma descrição', weight: 100, height: 100, width: 100, depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando descrição está vazia' do
      item = Item.new(name: 'Nome do produto', description: '', weight: 100, height: 100, width: 100, depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Peso está vazio' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: '', height: 100, width: 100,
                      depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Altura está vazio' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 100, height: '', width: 100,
                      depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Largura está vazio' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 100, height: 100, width: '',
                      depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Profundidade está vazio' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 100, height: 100, width: 100,
                      depth: '')

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Peso é menor que zero' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: -1, height: 100, width: 100,
                      depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Peso é igual a zero' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 0, height: 100, width: 100,
                      depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Altura é menor que zero' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 100, height: -1, width: 100,
                      depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Altura é igual a zero' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 100, height: 0, width: 100,
                      depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Largura é menor que zero' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 100, height: 100, width: -1,
                      depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Largura é igual a zero' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 100, height: 100, width: 0,
                      depth: 100)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Profundidade é menor que zero' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 100, height: 100, width: 100,
                      depth: -1)

      result = item.valid?

      expect(result).to eq false
    end

    it 'falso quando Profundidade é igual a zero' do
      item = Item.new(name: 'Nome do produto', description: 'Alguma descrição', weight: 100, height: 100, width: 100,
                      depth: 0)

      result = item.valid?

      expect(result).to eq false
    end
  end
end
