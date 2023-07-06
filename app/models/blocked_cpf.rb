# frozen_string_literal: true

class BlockedCpf < ApplicationRecord
  validates :cpf, presence: true, uniqueness: true

  validate :cpf_validator

  private

  def check_verifyer_digit_1(cpf)
    return if cpf.size < 11

    cpf_arr = cpf.split('').map!(&:to_i)
    factor = 10
    index = 0
    verification = 0

    9.times do
      verification += cpf_arr[index] * factor

      index += 1
      factor -= 1
    end

    rest = verification % 11
    [0, 1].include?(rest) ? 0 : 11 - rest
    cpf_arr[9]

    check_verifyer_digit_2(cpf)
  end

  def check_verifyer_digit_2(cpf)
    return if cpf.size < 11

    cpf_arr = cpf.split('').map!(&:to_i)
    factor = 11
    index = 0
    verification = 0

    10.times do
      verification += cpf_arr[index] * factor
      index += 1
      factor -= 1
    end

    rest = verification % 11
    first_verifyer = [0, 1].include?(rest) ? 0 : 11 - rest
    first_verifyer == cpf_arr[10]
  end

  def cpf_validator
    return if check_verifyer_digit_1(cpf)

    errors.add(:cpf, 'deve ser válido')
  end
end
