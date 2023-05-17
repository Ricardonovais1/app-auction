class Question < ApplicationRecord
  belongs_to :lot
  belongs_to :user

  # ================ ANSWER ASSOCIATIONS ===========

  has_many :answers 
  has_many :users, through: :answers

  validates :body, presence: true, length: { minimum: 10 }
end
