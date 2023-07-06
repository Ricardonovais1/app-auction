# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image

  after_create :set_admin_if_leilaodogalpao_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :registration_number, presence: true,
                                  uniqueness: true,
                                  format: { with: /\A\d{11}\z/, message: 'deve conter 11 dígitos' }

  validates :name, presence: true
  validate :cpf_validator
  validate :cpf_must_not_be_blocked_create_account, on: :create

  def cpf_must_not_be_blocked_create_account
    cpf_must_not_be_blocked(:create_account)
  end

  validate :cpf_must_not_be_blocked_bid_on_lot, on: :bid_on_lot

  def cpf_must_not_be_blocked_bid_on_lot
    cpf_must_not_be_blocked(:bid_on_lot)
  end

  validate :cpf_must_not_be_blocked_blocked_by_cpf, on: :blocked_by_cpf

  def cpf_must_not_be_blocked_blocked_by_cpf
    cpf_must_not_be_blocked(:blocked_by_cpf)
  end

  # ================ ANSWER ASSOCIATIONS =============

  has_many :answers
  has_many :questions, through: :answers

  # ================ QUESTION ASSOCIATIONS ===========

  has_many :questions
  has_many :lots, through: :questions

  # ================ BID ASSOCIATIONS ================

  has_many :bids
  has_one  :lot, through: :bids

  # ================ FAVORITE ASSOCIATIONS ================

  has_many :favorites
  has_one  :lots, through: :favorites

  # =================================================================

  def set_admin_if_leilaodogalpao_email
    self.admin = email.ends_with?('@leilaodogalpao.com.br')
    save!
  end

  # =================================================================

  def favorite_lots
    favorites.map(&:lot)
  end

  # =================================================================

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
    check_verifyer_digit_1(registration_number)
  end

  def cpf_must_not_be_blocked(action)
    return unless BlockedCpf.where(cpf: registration_number, blocked: true).exists?

    case action
    when :create_account
      errors.add(:registration_number, 'está bloqueado')
    when :bid_on_lot
      errors.add(:registration_number, 'bloqueado. Lance não permitido')
    when :blocked_by_cpf
      errors.add(:registration_number, 'bloqueado. Mensagens não permitidas')
    end
  end

  def user_first_name
    name.split(' ')[0]
  end
end
