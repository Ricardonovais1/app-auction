# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lot, type: :model do
  describe '#valid?' do
    context 'campos vazios' do
      it 'falso quando código está ausente' do
        lot = Lot.new(code: '', start_date: '2090-10-20', limit_date: '2090-10-30',
                      minimum_bid_value: 100, minimum_bid_difference: 10,
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

        result = lot.valid?

        expect(result).to eq false
      end

      it 'falso quando data de início está ausente' do
        lot = Lot.new(code: 'AAA000000', start_date: '', limit_date: '2090-10-30',
                      minimum_bid_value: 100, minimum_bid_difference: 10,
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

        result = lot.valid?

        expect(result).to eq false
      end

      it 'falso quando data limite está ausente' do
        lot = Lot.new(code: 'AAA000000', start_date: '2090-10-20', limit_date: '',
                      minimum_bid_value: 100, minimum_bid_difference: 10,
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

        result = lot.valid?

        expect(result).to eq false
      end

      it 'falso quando valor mínimo está ausente' do
        lot = Lot.new(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30',
                      minimum_bid_value: '', minimum_bid_difference: 10,
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

        result = lot.valid?

        expect(result).to eq false
      end

      it 'falso quando diferença mínima está ausente' do
        lot = Lot.new(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30',
                      minimum_bid_value: '100', minimum_bid_difference: '',
                      by: 'Ricardo', by_email: 'ricardo@leilaodogalpao.com.br')

        result = lot.valid?

        expect(result).to eq false
      end
    end

    context 'código' do
      it 'já está em uso' do
        Lot.create!(code: 'AAA000000', start_date: '2090-10-20', limit_date: '2090-10-30',
                    minimum_bid_value: '100', minimum_bid_difference: '10')
        second_lot = Lot.new(code: 'AAA000000', start_date: '2090-03-05', limit_date: '2090-03-20',
                             minimum_bid_value: '200', minimum_bid_difference: '20')

        result = second_lot.valid?

        expect(result).to eq false
      end

      it 'tem menos ou mais de 9 caracteres' do
        lot = Lot.new(code: 'AAA000', start_date: '2090-03-05', limit_date: '2090-03-20',
                      minimum_bid_value: '200', minimum_bid_difference: '20')

        result = lot.valid?

        expect(result).to eq false
      end

      it 'não possui 3 letras e 6 números, nesta ordem' do
        lot = Lot.new(code: 'A3A000000', start_date: '2090-03-05', limit_date: '2090-03-20',
                      minimum_bid_value: '200', minimum_bid_difference: '20')

        result = lot.valid?

        expect(result).to eq false
      end
    end

    context 'data de início e fim' do
      it 'falso se data de início é posterior à data limite' do
        lot = Lot.new(code: 'AAA000000', start_date: '2090-03-20', limit_date: '2090-03-05',
                      minimum_bid_value: '200', minimum_bid_difference: '20')

        result = lot.valid?

        expect(result).to eq false
      end

      it 'falso se data de início é anterior à data atual' do
        lot = Lot.new(code: 'AAA000000', start_date: 2.day.ago, limit_date: 1.week.from_now,
                      minimum_bid_value: '200', minimum_bid_difference: '20')

        result = lot.valid?

        expect(result).to eq false
      end
    end
  end
end
