class Question < ApplicationRecord
  belongs_to :lot
  belongs_to :user

  validates :body, presence: true, length: { minimum: 10 }
end
