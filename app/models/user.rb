class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  validates :registration_number, uniqueness: true
  # validate :cpf_validation

  

  # def cpf_validation(cpf)

  # end
end
