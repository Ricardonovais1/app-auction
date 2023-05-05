class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  after_create :set_admin_if_leilaodogalpao_email

  # scope :visitor, -> { where(admin: false) }
  # scope :admin, -> { where(admin: true) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :registration_number, presence: true, 
                                  uniqueness: true, 
                                  format: { with: /\A\d{11}\z/, message: "deve conter 11 dígitos" }

  validates :name, presence: true
  validate :cpf_validator 

  # =================================================================


  def set_admin_if_leilaodogalpao_email
    self.admin = email.ends_with?('@leilaodogalpao.com.br')
    save!
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
    
    verification
    rest = verification % 11
    first_verifyer = rest == 0 || rest == 1 ? 0 : 11 - rest
    first_verifyer == cpf_arr[9]

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
    
    verification
    rest = verification % 11
    first_verifyer = rest == 0 || rest == 1 ? 0 : 11 - rest
    first_verifyer == cpf_arr[10]
  end

  def cpf_validator  
    check_verifyer_digit_1(registration_number)
  end
end
