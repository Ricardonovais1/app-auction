class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :registration_number, presence: true
  validates :registration_number, uniqueness: true

  validate :cpf_validator 


  def check_verifyer_digit_1(cpf)

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
  end

  def check_verifyer_digit_2(cpf)

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
    false if registration_number.size > 11 || registration_number.size < 11
    registration_number.gsub(/\.|\-/, '') 
    check_verifyer_digit_1(registration_number)
    check_verifyer_digit_2(registration_number)
  end
end
