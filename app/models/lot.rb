class Lot < ApplicationRecord
  validates :start_date, :limit_date, :minimum_bid_value, :minimum_bid_difference, presence: true

  validates :code, presence: true, 
                   uniqueness: true,
                   length: { is: 9 }

  validate :code_format_validation
  validate :start_date_validation
  validate :limit_date_validation

  def validate_characters(str)
    str.match?(/\A[a-zA-Z]+\z/)
  end

  def validate_numbers(num)
    num.match?(/\A\d+\z/)
  end

  def code_format_validation
    return if code.empty?

    characters = code.slice(0, 3)
    numbers = code.slice(3, 9)
   
    if !validate_characters(characters) || !validate_numbers(numbers) 
      errors.add(:code, message: 'deve ter 3 letras e 6 números')
    end
  end

  def start_date_validation
    if self.start_date.present? && self.start_date <= Date.today
      self.errors.add(:start_date, ' deve ser futura')
    end
  end

  def limit_date_validation
    if self.start_date.present? && self.limit_date.present? && self.start_date >= self.limit_date
      self.errors.add(:limit_date, ' deve ser maior que a data de início')
    end
  end
end
